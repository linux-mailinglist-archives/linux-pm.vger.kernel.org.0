Return-Path: <linux-pm+bounces-22021-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6087DA346C9
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2025 16:28:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17DB41898DDB
	for <lists+linux-pm@lfdr.de>; Thu, 13 Feb 2025 15:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554B214A605;
	Thu, 13 Feb 2025 15:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x2QCH6gy"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BFE13D8A4
	for <linux-pm@vger.kernel.org>; Thu, 13 Feb 2025 15:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739460041; cv=none; b=HDaeAKRXEzE4la3dGzpAQkPM9JFo5T3pfr7F1exZMRA9AIzlv+QbM95oS3cSlA4TEo/Q0HH/d+XNVB8ahR279RqOGG8xbONLdU0wMnj0gn1Q62wK3fCO1faL+L6mYd2yfFUfjNOL8lOAiAov7Ty0+NNfA4unMKc9yuuq5PEnFwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739460041; c=relaxed/simple;
	bh=rfpPomdaAuC/C/fVrS0p4u4D+n8uN16/rL49lRiJWnY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ho1Nt/FV6fbUpp+gvaH3Uxa4ceOFqSCQE0BY2BAjm+8WNE+yARskRI0/pZkUgIgG3K426xGyAjzkCaj7pgvrKzeOrtN87w8ozDucJXKebhPzg2dFqEPEc9z95dpnb58UoHE2tlPSvrjUBs+oVe/VHBYEKPWcOE4IuzBAhRWkk14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=x2QCH6gy; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-e5b4d615267so936167276.1
        for <linux-pm@vger.kernel.org>; Thu, 13 Feb 2025 07:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1739460038; x=1740064838; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rfpPomdaAuC/C/fVrS0p4u4D+n8uN16/rL49lRiJWnY=;
        b=x2QCH6gyWVWNjpe2+HEgLP1mqY/X5n2KqG+LvZ9wohdc6WeENRtHM6pDJT0OTSyHOz
         2Dkt+6p+/3lf1Oyot9hGsxQ1vD1RwJ8mxMRnYtLUdV6kzXK3e2Lku5c3PyAHIKwS/PYF
         5lmLxMn5zcxxfiPd9dAgIEzXyRRqWeWtGRsZcHVniB1+naFAdYVQqV76DFsdJiZONxWG
         kmJexM4lKtIvcogsKJFH7sb14vSYu8U714KhWbqGdWdgUhrwV8zRh2WyZ6NZZepP5z0g
         44L/3fDzxfKA0CWBrzczWv/Sqz/VAelBljA1fOBCXUG+j1E/bMbc8lsjTElsQu7uA9k+
         X0Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739460038; x=1740064838;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rfpPomdaAuC/C/fVrS0p4u4D+n8uN16/rL49lRiJWnY=;
        b=MPHIaYdjRp1ZEjafXc/PiwR6y2YDqFMV4OHE5LAQxHmRfLII3F7f5eNhlS87bPWJZB
         GQfNt+7pCyB58ik+JDIPO5EL+lrnz+ovuOnHq1q+blF5TCSXxO2AfAnDmeU/t3SMKhfn
         +6xAGZRht3+QQPsHFfbHBcMPJ4exSgjerNODW7pRG7jVjJI/DkEeNbM3nC7yKBiHnO2Q
         EPlqnkzXDvmg+fXcFQ3n7DUTX8bmGHq8Q7cOuoJXdjbzrapxEFBc8cBzskmNIC2ylDmn
         jnPaG409lOnkcM3JNtCK/YpZ95riOhpGmI3NyC18dPLSnJihHEXp9mMP6LSG6OZ71b70
         MdkA==
X-Forwarded-Encrypted: i=1; AJvYcCV37x5i6EkrCESj65Mu6Ike+LBVP7bz1aAzwdqFoFFriTDFwgknJOClTR/VzqgmuKz727AD/9OokA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3T7tg4V0A5MCbth9uNoKFzjtRwOfhY5wb1qDLU5laZfeLi9pS
	9wZ2Hlq9YT4QXvYYJuA8E6SUe2nTYV5SG0SeQjheX94uJyHkCrAvTXeVvbK8GVs0RiFLfSsLIdw
	ua2wE4w5sjMHGTBLYHfkBZ1H26Mv+ITd6SJJGdA==
X-Gm-Gg: ASbGncuci9nPt3bW7eZx1ojwfIRQUgdgUDxiFM7HLzEolFAzQQ/GWKIJ2SEQdB2h3ZK
	Uy/RHJcbpsIMWT1oN/QiVBDGRjsEVUVsmn3K0HW2LSj2MbDBC7gWdlOeMxDj6UrBCNA4YX5zmgg
	==
X-Google-Smtp-Source: AGHT+IFl/TG61rvCBbheyo/94kyjI8M7amCo+Z6FRtUrkr7CyRBFmSwZjs8C3zZwm91mmD1mfp5rexOLBEr+jyGCvjE=
X-Received: by 2002:a05:6902:1206:b0:e57:f8cd:f0a4 with SMTP id
 3f1490d57ef6-e5d9f1793cemr7130963276.34.1739460037910; Thu, 13 Feb 2025
 07:20:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <1738736156-119203-1-git-send-email-shawn.lin@rock-chips.com>
 <CAPDyKFq+pWXq75xEtfkeCkmkdZtfp9dAFej4M+6rO6EAUULf=w@mail.gmail.com> <yq14j0y25hd.fsf@ca-mkp.ca.oracle.com>
In-Reply-To: <yq14j0y25hd.fsf@ca-mkp.ca.oracle.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 13 Feb 2025 16:20:01 +0100
X-Gm-Features: AWEUYZklR9qSyrIhPSPo_ng6rtBVVDlndlqorR6YtDIMuUhis6JkRbA7309T0XU
Message-ID: <CAPDyKFqsiBaSV--a_SvJ1n0733XXjSoONztf0e=jsGTZhKxQJw@mail.gmail.com>
Subject: Re: [PATCH v7 0/7] Initial support for RK3576 UFS controller
To: Shawn Lin <shawn.lin@rock-chips.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: "James E . J . Bottomley" <james.bottomley@hansenpartnership.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Heiko Stuebner <heiko@sntech.de>, "Rafael J . Wysocki" <rafael@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
	Avri Altman <avri.altman@wdc.com>, Bart Van Assche <bvanassche@acm.org>, 
	YiFeng Zhao <zyf@rock-chips.com>, Liang Chen <cl@rock-chips.com>, linux-scsi@vger.kernel.org, 
	linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, 
	linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 12 Feb 2025 at 22:56, Martin K. Petersen
<martin.petersen@oracle.com> wrote:
>
>
> Ulf,
>
> > If so, may I suggest that I pick patch2, patch3 and patch4 via my
> > pmdomain tree and share them via an immutable branch, so they can be
> > pulled into James/Martin's scsi tree?
>
> Sure, that's fine with me.

Okay, great! I have picked up the patches and pushed them to the below
immutable branch, which is based upon rc2.

git.kernel.org/pub/scm/linux/kernel/git/ulfh/linux-pm.git rockchip

Kind regards
Uffe

