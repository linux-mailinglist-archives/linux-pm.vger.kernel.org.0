Return-Path: <linux-pm+bounces-30473-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A0FB4AFE7DD
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 13:33:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A63A18877C7
	for <lists+linux-pm@lfdr.de>; Wed,  9 Jul 2025 11:33:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B8D2D6636;
	Wed,  9 Jul 2025 11:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="U/O3yJ0D"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCF46226D16
	for <linux-pm@vger.kernel.org>; Wed,  9 Jul 2025 11:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752060786; cv=none; b=P87aIcY1RW90NF8qzNPW8v3uYwMUqFdxNmPfG48N8euRnC4LFoFDd+/MMBSyoAaYV7UxqY/+hcBEMRVFhH3La+C7gkm7nFyM513RzZGrcxjT2XAheG0qD3pFMvXTsjZ50R65ZhGrh8yW/tU1PNAUIPPiomirhyOeaL1yeFB0lIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752060786; c=relaxed/simple;
	bh=DnetqG4IpAFzDIBOiu8occs+wrG3pJXMqq/lD/+CZz4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=H+LYBycIxx86PQLLLfwkSrsG0PP8ztIF4O5YXJX+udtHtdS9X91TWx4XQT7R/3DIP3XB7IwFWlS75gOYxDNPXwox0LKkTGyiPdbqqd05dDtia8z+M6xoQpY2J6BrrO/Kd79wsTw76+q2pn9pGiGnfslXj+U4VAwVNDWy8RVmp0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=U/O3yJ0D; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-ae3cd8fdd77so1143076366b.1
        for <linux-pm@vger.kernel.org>; Wed, 09 Jul 2025 04:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1752060782; x=1752665582; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KxzY42f4mxHddEBUOVLLBJrN9aKCSop49so8dLkLQco=;
        b=U/O3yJ0DN6baKxv96FqzOocjvo45nVp8hpkpdara9EBtCODvwbHYkh85hmgXQuepCQ
         6r+M7hwY/lWt7+6gGFPu/PgBusr4yBAW0SBJPSOjroaY3T/b2oY/IhMWRD0DHIc5FECB
         KEJkW4b2jbJlXiQjYZoNJqO4C5Dw9R5Cm5dnlNSxoT3SVMPLsiBWsApd3ArSED2iJRF7
         kNPCzd9j3+jTSuCY0CCcEdqhf5laX7gIPG24ABli63mSv+h+tw6Dl+HgQ2x5angC6rX0
         1h6oYofb4mNsVNb3jbyVYROXUtfcyHKdIi5b4dPflY+h7ge6u6z3C/7Y2+Qt9V+jLQW7
         awuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752060782; x=1752665582;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KxzY42f4mxHddEBUOVLLBJrN9aKCSop49so8dLkLQco=;
        b=bfl7BvpFeo+N8L6N6E8/4dZSamlu1kTfNh7ATDQwPRPbI2zwrqzCY+n+vPk35It7jj
         oHGN9vGcowAwpPExJN0mm62TW6A72nacy1QCVJlhZ3a2Bd1DycP1mWhzINCV+2nlqdZQ
         xC7z4z+3vZ30Ypsr4Bif0cxbACb+dVZM23w1KdAQQFVmABKIROmwn0qqpmAOkTT3Ickr
         YsIwQiHN2Al/eTdhsEhnIjMm7inVdrhxlSdadhhhx9/8I0B5CxYy4Emv3PIbuKk9X7UX
         6i7kCLHfuQ3kOcfKsvV0y0+ZHzpq1tzGWKUeOuCoqAvJxd6x3T72h15mVSE5/vC3UYnX
         ZXLA==
X-Forwarded-Encrypted: i=1; AJvYcCXuawZgrnI0vJZhR33d1G0LKk3ei5Z7DJ4sYVYJD8/Cdw4fUyHZqBPegQb1IyZ18WEXcHgHyJUB6A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxb61tNgAvt82WhhwfOkXxAaU/bLLk7hOwKBP4QpyGJfZah6J4L
	H7CBT+4zgYFyT9WMy39/LTaSZ0p4KHncaRk9eG0RRf0L9jvK78ViIKoa9oc5z38dMb8=
X-Gm-Gg: ASbGnctpsxajoiPSx3jGXrr4dCeqOArj9o2t8LGUKYTYOdn6hU3KzsBrQajPBYG7Q0+
	nepl2WbhX2OVwatJinBMxyHkIMHiF5VcGcpLB5KNi/gJVC3mTegshIps6DoOIi668eToUmH+jwd
	QKsbAONwFyBGNUfpvHKB+Zde2kRZY3hWuYbgMjJE9yvDgqs60F0U7jBQTL0/foe3k9CQ7y3ih6X
	VKS0GzTBKY4Q10BQZl/kZiiz7RxN65chpb73Wrx6eii7PRlUb6WeUomt1c4x4h58YlfMUis4x5p
	CSiECggUPuP7sV5gE5RUpHXgYW2FUgEC0X9sR+4KkyrLdC6IewcU4tOsgZIVV8cM2yAwNYAyHJW
	vI3EF8ls/OyF/qWjQTukL28QeZkpoYqMLct5NHhNjMw==
X-Google-Smtp-Source: AGHT+IGHM8DEDRJmkix2Dsy2SirVJ7BbYv4bV5HgWFOqwJ5zCocvDi8X0Hn8U2z4qSsef7dQPV0KjQ==
X-Received: by 2002:a17:907:6ea3:b0:ad8:a41a:3cba with SMTP id a640c23a62f3a-ae6cfc3c275mr235877666b.43.1752060781983;
        Wed, 09 Jul 2025 04:33:01 -0700 (PDT)
Received: from localhost (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae3f6bb1edfsm1080433666b.180.2025.07.09.04.33.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jul 2025 04:33:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 09 Jul 2025 13:33:01 +0200
Message-Id: <DB7HPNBDW93U.2RC0AF8T8RG5Y@fairphone.com>
Cc: "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Bjorn
 Andersson" <andersson@kernel.org>, <~postmarketos/upstreaming@lists.sr.ht>,
 <phone-devel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v2 0/2] Add Milos RPMHPD power domains
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Ulf Hansson" <ulf.hansson@linaro.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250707-sm7635-rpmhpd-v2-0-b4aa37acb065@fairphone.com>
 <CAPDyKFonLENQbafjo621hHPkoWjMNoQ5GRNeNndpezMNnM1=sA@mail.gmail.com>
In-Reply-To: <CAPDyKFonLENQbafjo621hHPkoWjMNoQ5GRNeNndpezMNnM1=sA@mail.gmail.com>

On Wed Jul 9, 2025 at 1:30 PM CEST, Ulf Hansson wrote:
> On Mon, 7 Jul 2025 at 12:18, Luca Weiss <luca.weiss@fairphone.com> wrote:
>>
>> Add support for the rpmhpd power domains in the Milos SoC.
>>
>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>
> The series applied for next (with a minor update to the commit message
> for patch1, according to suggestions from Krzysztof), thanks!

Thank you!

>
> Kind regards
> Uffe
>
>
>
>> ---
>> Changes in v2:
>> - Rebrand SM7635 to Milos as requested: https://lore.kernel.org/linux-ar=
m-msm/aGMI1Zv6D+K+vWZL@hu-bjorande-lv.qualcomm.com/
>> - Link to v1: https://lore.kernel.org/r/20250625-sm7635-rpmhpd-v1-0-92d3=
cb32dd7e@fairphone.com
>>
>> ---
>> Luca Weiss (2):
>>       dt-bindings: power: qcom,rpmpd: document the Milos RPMh Power Doma=
ins
>>       pmdomain: qcom: rpmhpd: Add Milos power domains
>>
>>  .../devicetree/bindings/power/qcom,rpmpd.yaml         |  1 +
>>  drivers/pmdomain/qcom/rpmhpd.c                        | 19 ++++++++++++=
+++++++
>>  2 files changed, 20 insertions(+)
>> ---
>> base-commit: 19272b37aa4f83ca52bdf9c16d5d81bdd1354494
>> change-id: 20250620-sm7635-rpmhpd-dcb5dc066ce2
>>
>> Best regards,
>> --
>> Luca Weiss <luca.weiss@fairphone.com>
>>


