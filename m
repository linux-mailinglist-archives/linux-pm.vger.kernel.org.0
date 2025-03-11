Return-Path: <linux-pm+bounces-23825-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52727A5BADC
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 09:31:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0284218964F1
	for <lists+linux-pm@lfdr.de>; Tue, 11 Mar 2025 08:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7918222596;
	Tue, 11 Mar 2025 08:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LjXmG8xE"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA791DEFFC;
	Tue, 11 Mar 2025 08:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741681868; cv=none; b=Ogrhp7ncIoCdoUIkZdjGlF2SHTgP11SdNHWvDa4zU5fpLUzTnaMLQ47en604bgquYww+Z6kaHBxVvBaWUT6UD3q60q9d3/Txaw4+V078crVSNM7aS2P2Zgq9RmW2N/O9M8YjBOX0WnGTplKgiG9QMiHBxIdNWAGUif3zQmBYA5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741681868; c=relaxed/simple;
	bh=BGW2xjHkisXT7pqum8togihsMgIsMxwH1FSSG/BF3c4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RJkMkvfUZQpgrvOYu35GSuw6ljjI+WQIdFxag7117jiI6GGQ35ynFVyAVq9PboIPNE+cEYIw2QdvxeSq6+Bq5UPkWuM8UN5ZtwTDH4yB6lwEesM0ovSP8qdyW7uigqGk6wwDkyLNmi6RhRqaC1Bz1ABAURFOPRBJH7Apjcel39s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LjXmG8xE; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43cef0f03cfso14649355e9.3;
        Tue, 11 Mar 2025 01:31:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741681865; x=1742286665; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BGW2xjHkisXT7pqum8togihsMgIsMxwH1FSSG/BF3c4=;
        b=LjXmG8xEf+p5FyDkVUBhE2W8moNOHqwfreU7GAudZcOBZkFM1tvTVran17tL+UO36t
         hoagUUiAFyzXlb4f4aZQ1Vw49b3U/AvJ6D/2AIYlywnzHw8aWZyf8QHlAjY0ZwpKLu8M
         7wBvZUoYUGS85+BM/aNtlN2hpxnTPu4Nt3mnjZi/pX9iSQYHjaOFqiCueHhp6LHZ+J1J
         R02NHZi6FhMSi3Y+ejfbX+FQ7DrS5msI1Sw2njuWtumP7TTEn7I5mz0WM0x/DpSG24Ug
         wGlYmH5+rn1mg/6CNndVdV4yQeV482nS3DEVIGNlu11nR3ffVfrTBN0CI3zJuiHxlCOo
         5Fzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741681865; x=1742286665;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BGW2xjHkisXT7pqum8togihsMgIsMxwH1FSSG/BF3c4=;
        b=Y3FDCInqGdZYWeIpWLCZUdRT4bhQa7aqR2YUOeL0WFTIUl3swzppi/jR3jmbGvh20u
         uHEfsnhTo9v/cqGReWJEioMBVj7sAtFDTUuuyiXAQOYB33kslDQLwWFQxy/gyOXOevLF
         HeDLtza4jX33H3+r1Q4V+NO5LSx5P+mxdVDa0E04wRnt96KcgpJC5s1q+xlUb0V5rWLq
         KsRaBaiabR/zxSox+stWf6oqhjwou5naGNN+N7w6meAHmFusa3tGSr98O5LnIvMdua89
         mQ0KLy51B0CGmeKu8kGxgvRLtraW0GFuiTf+B16kshQR+QAYFRkmilIIvw0evQVslyEv
         qPiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUUVLjNHfkJRuZ7LHU9tZdMA98UUDnIOwDLISnweZqVzbXy2sQmEPslOJMci90moDREOhvWcNPc5Qg=@vger.kernel.org, AJvYcCVVO52Gpj1L/4RzFwdvbkw0Wg7eBbSNLRLd3LQ6NKfr9X2f03XaJ6ievO8MoUA+Oqd72cjooTjX6hCym6vC@vger.kernel.org, AJvYcCWKDf5dfQxWy+qLQK9puLe2LtHj4nnQB9mnk6HpsQdvSEYjNmFUUmWhXqK2lto8rv6fTHbyB2PYkzHH@vger.kernel.org
X-Gm-Message-State: AOJu0YyCzeCdGH6C8bE7eMnbC0R/xuZtx0QWdBzH8RpWyZE/RsPETn3O
	KzXHTgYDoTI6UrBDbN9dWBV6Yjd15uWMNWk6EmP8V/43IWfiR3r1BUI2mExjMzSYC7LT6RlGUfe
	9/FxpyValgEi/epqLMHy82kAjBOg=
X-Gm-Gg: ASbGnctQ79uweDlu0tmduA1GrpSsbdj/OuuX8l3yS3mR9EZgBAuAt0+WJ9+VMj7olV0
	TF9/m39aKPMjWbVsxRLUFEUAttVWyCvmoehqybUOpDojGIu/xmpCI6wID/VI27zfyPrehBUvE3C
	I8zoP6EnuMqoS72fizl7hFRbKWvNs=
X-Google-Smtp-Source: AGHT+IE+L3iP1ptVXujFE1IrSzeuM+PwAHxLRpuFcfrOKyHRlhpVneGlX9ZHBUJyo9JOfVFbrXvGKuwDT6uQPpvizGQ=
X-Received: by 2002:a05:600c:5107:b0:43d:1c3:cb2e with SMTP id
 5b1f17b1804b1-43d01c3cc32mr33986075e9.17.1741681865076; Tue, 11 Mar 2025
 01:31:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250310075638.6979-1-clamor95@gmail.com> <20250310075638.6979-2-clamor95@gmail.com>
 <dc772e9e-632f-4c38-a654-833df0800ee1@kernel.org>
In-Reply-To: <dc772e9e-632f-4c38-a654-833df0800ee1@kernel.org>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Tue, 11 Mar 2025 10:30:51 +0200
X-Gm-Features: AQ5f1JpwBog-7Y7fjy7skHuEPi-yk7Ha-Rqtse4SxqjZKJte1dWwFKZkOiMzBzM
Message-ID: <CAPVz0n2kZqLbaju5G-NhYzjJ+cLrXaJg6bU0_GFL6oga_f4Qyg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] dt-bindings: thermal: generic-adc: Add optional
 io-channel-cells property
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Laxman Dewangan <ldewangan@nvidia.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=B2=D1=82, 11 =D0=B1=D0=B5=D1=80. 2025=E2=80=AF=D1=80. =D0=BE 10:20 Krzy=
sztof Kozlowski <krzk@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On 10/03/2025 08:56, Svyatoslav Ryhel wrote:
> > This implements a mechanism to derive temperature values from an existi=
ng
> > ADC IIO channel, effectively creating a temperature IIO channel. This
> > approach avoids adding a new sensor and its associated conversion table=
,
> > while providing IIO-based temperature data for devices that may not uti=
lize
> > hwmon.
> >
>
> You got comments from Rob few days ago to which you did not respond.
> Instead you decided to send next version, which hides the previous
> unresolved discussion.
>
> This patch does not look necessary based on earlier discussion.
>

ok, I will remove this schema change

