Return-Path: <linux-pm+bounces-19924-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA91FA0059F
	for <lists+linux-pm@lfdr.de>; Fri,  3 Jan 2025 09:18:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D5E951883217
	for <lists+linux-pm@lfdr.de>; Fri,  3 Jan 2025 08:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABCBB1B21B5;
	Fri,  3 Jan 2025 08:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nlYvctJ5"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55834C62;
	Fri,  3 Jan 2025 08:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735892322; cv=none; b=gBV/G96oF97WRByUzkFkYd/v4BgCisY7fNBDF/M+glOZG3FaxfdICDR7FhXv7I2OiwXnQ9JAbk/bzBSRUY3ZJg8oZwE2uw4dKtjBdjuk5S1jfNQ+XPspqjDx6veFxNmcxhxViT57sfsPLuTlIL2NT20ZuWo0ArcbDicGMniVwGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735892322; c=relaxed/simple;
	bh=K3wJ0TvRCtSqRgKug8Sn25j3uJvP7LlhU6/zWB0eIFM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fqRynFrvvAEXa3Qq85p7bnPuy5c8ULisMFAVegC/N4S5WtZm/ZxU3eOmEPHVt1vIkt1ynNhGbEoTYF5jDnpUDBBrcpWcTY/4PPaMNoMD3WmJh9yrcEBUepRAbZXyj1WAW8PLpeiYNzABWpjQ1Af6fYtWdoUMKxl0vUKpN0TQ/w4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nlYvctJ5; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4362f61757fso119543295e9.2;
        Fri, 03 Jan 2025 00:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735892319; x=1736497119; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NR5TLumpUXqySQzU5N+KOwDryzVc0SnujL5LqMplskg=;
        b=nlYvctJ5tvaC4Y+1Xg8AkqCWFotYLS+84as9NBBG09FleM09g44FUlXfP/3BRA5SpW
         7dk3KbAk7yNTMtyvjmZXpXrGRqMBdVLUWJDF3F0yMQGmKFKxIMuHSr7mlPmBTtNa4q7Y
         +QmE+mpyo7ISM5D9maFBPoCULtfafH6a8sNpZ4j3EvqcLa8DzQe2HhcaTKWfHEEArpAf
         GCW/NSwC+EuXAGqZtYRQo/S3xJA/pTBQb2QptM0xGUjjPXulfPj3jHAiRdnvSpk326t2
         1uNds+QgWs1Sx6/IYQGsvcD4L4oa1Vyhfctfvditc+3vVXhTmfZZIeezwk1rV/jyJFzE
         zUxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735892319; x=1736497119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NR5TLumpUXqySQzU5N+KOwDryzVc0SnujL5LqMplskg=;
        b=OgLFOOgBSPm0uOsxPDsNawqVuDczCvmReQ868ILT2osSu3l7VCLfTEdskM2zurqCcH
         mk7F6kI5SM7kHtOcw0Fv/qS1GtTQ1yjzij/bo4ZzvaY+BWWM4sUopywW8fdXtaoamh2A
         1Zh2LYuB24Y24v2iK2kjAQYCsIpOA2D/qzZQgySRSp64+zzSMviYwfrMVS/Rt5lDJqBZ
         KnB7TUTdIBgcfqb023/J7PgXLI68mbYTPXxiBcimLXXsXhVy5tEZDqnh+TEdR4giAv4V
         hCsT7LNrraUfyrabKcOJ3ysNnubQPf5L71ZqSUJPOaoMzelyvbP3mYcCPKvCqfyu7mwU
         00wA==
X-Forwarded-Encrypted: i=1; AJvYcCUM1bH2N+DkFPoTkxe3U9m93u5XUzuTLXbi1ZAIooMqg3Q5RLCeQufpyAX/mRtHrNpkKnIj/bW4ThY=@vger.kernel.org, AJvYcCW1ne9A0N8rp55D+L6cDinmIGKuP1FyLdMDHLwZiJf7KA50duo3jzsYVkO9+osmg5zwC/Psi51NNRtwIDFB@vger.kernel.org, AJvYcCX9zSZxnQrZHg9UONtHhjfzFqC5XBW79+4WM2q4bEiZ57OriOoo5ht/TM3T+RHdqfwjSF4C8D12kL2W@vger.kernel.org
X-Gm-Message-State: AOJu0YwRRSwMHUu++WNB20LTKn3bFD7+dRDAYpRt9JltXUSiDpFKEza7
	O+Cy0CaLmvtE6HGWE3j3ZISuaNnrsqpGPa9davwKVcjYP7c02VD0
X-Gm-Gg: ASbGncv5ceY+txxtKocuPFj9sC+rYtKuCEskZw42BAoLUmggJ6IJ+xCOfipbpaBMSWu
	ePLnsZBdD+F/duoVQOHv81jmkniy+PReJfq8pC5+Rk6XofF4xEROHF7FVXgPTkC4gvw0gk9IzZz
	I+XAkeZ2GTB3I9i7EZIJSZHLXMhaxs51ZGWaUA3SUeAGc2AsShzFW0mGLp8QAjRtfiEG/RNCl4j
	YLpO2wFZDlFUeitUR9UWpjxls9H49XA4ZVvwrLZNdQaSl9m5MbTUusZHAZu8NFPK/MoXUpoDcC8
	mCbrvfWWuNmNCRIQlq7lOPNIVeEuEseL1kcJKtQMnU0HL3ysxpqFUu0=
X-Google-Smtp-Source: AGHT+IEDWtjrfgBu2Lwgphy2XXzRXCiSCr1c1zSvfcnmhwlhX4YgIGVpjbOz4wnVROt2uySv+Blgtg==
X-Received: by 2002:a05:600c:1c1a:b0:434:a746:9c82 with SMTP id 5b1f17b1804b1-4366854725cmr405100855e9.5.1735892318802;
        Fri, 03 Jan 2025 00:18:38 -0800 (PST)
Received: from stefan.beckhoff.com (dyndsl-082-149-177-181.ewe-ip-backbone.de. [82.149.177.181])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-43656b013e1sm504092085e9.12.2025.01.03.00.18.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2025 00:18:38 -0800 (PST)
From: Stefan Raufhake <raufhakestefan@gmail.com>
To: krzk@kernel.org,
	sebastian.reichel@collabora.com
Cc: sre@kernel.org,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	s.raufhake@beckhoff.com,
	s.dirkwinkel@beckhoff.com,
	s.raufhake@beckhoff.de,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Subject: Re: [PATCH v2 1/1] power: supply: gpio-charger: Support to disable charger
Date: Fri,  3 Jan 2025 08:18:36 +0000
Message-Id: <20250103081836.4499-1-raufhakestefan@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <a319101a-ab6a-40fd-9753-0593641b08f6@kernel.org>
References: <a319101a-ab6a-40fd-9753-0593641b08f6@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hallo, 

>
> On 19/12/2024 01:58, Sebastian Reichel wrote:
> > Hi,
> >
> > On Mon, Dec 16, 2024 at 08:30:45AM +0100, Krzysztof Kozlowski wrote:
> >> On 13/12/2024 11:28, Stefan Raufhake wrote:
> >>> Hallo Krzysztof,
> >>>
> >>>>
> >>>> On Tue, Dec 10, 2024 at 09:23:43AM +0000, Stefan Raufhake wrote:
> >>>>> From: Stefan Raufhake <s.raufhake@beckhoff.de>
> >>>>>
> >>>>> Some GPIO-controlled power supplies can be turned off (charging disabled).
> >>>>> Support changing the charging state by setting charge_type to
> >>>>> POWER_SUPPLY_CHARGE_TYPE_STANDARD and disabling charging by setting
> >>>>> charge_type to POWER_SUPPLY_CHARGE_TYPE_NONE. One potential use case for
> >>>>> this is disabling battery backup on a UPS.
> >>>>>
> >>>>> Signed-off-by: Stefan Raufhake <s.raufhake@beckhoff.de>
> >>>>> ---
> >>>>>  .../bindings/power/supply/gpio-charger.yaml   |  6 +++
> >>>>>  drivers/power/supply/gpio-charger.c           | 43 +++++++++++++++++++
> >>>>>  2 files changed, 49 insertions(+)
> >>>>>
> >>>>
> >>>> <form letter>
> >>>> This is a friendly reminder during the review process.
> >>>>
> >>>> It seems my or other reviewer's previous comments were not fully
> >>>> addressed. Maybe the feedback got lost between the quotes, maybe you
> >>>> just forgot to apply it. Please go back to the previous discussion and
> >>>> either implement all requested changes or keep discussing them.
> >>>>
> >>>> Thank you.
> >>>> </form letter>
> >>>
> >>> Sorry, it seems I made a mistake during the patch review process.
> >>> Should I reply to your email about version 1 of the patch or only about
> >>> version 2? I don't want to make another mistake and open two discussions
> >>> at the same time.
> >>> I hope to do better in the future.
> >>>
> >>>>
> >>>>> diff --git a/Documentation/devicetree/bindings/power/supply/gpio-charger.yaml b/Documentation/devicetree/bindings/power/supply/gpio-charger.yaml
> >>>>> index 89f8e2bcb2d7..084520bfc040 100644
> >>>>> --- a/Documentation/devicetree/bindings/power/supply/gpio-charger.yaml
> >>>>> +++ b/Documentation/devicetree/bindings/power/supply/gpio-charger.yaml
> >>>>> @@ -44,6 +44,10 @@ properties:
> >>>>>      maxItems: 32
> >>>>>      description: GPIOs used for current limiting
> >>>>>
> >>>>> +  enable-gpios:
> >>>>> +    maxItems: 1
> >>>>> +    description: GPIO is used to enable/disable the charger
> >>>>> +
> >>>>
> >>>> You did not respond to my comments, nothing improved. Without
> >>>> explanation based on hardware - which I asked - this is still a no.
> >>>>
> >>>> Implement and respond fully to previous feedback.
> >>>>
> >>>> Best regards,
> >>>> Krzysztof
> >>>>
> >>>
> >>>
> >>> Sorry, I'm new to this and don't really know what exactly you want for the
> >>> hardware description and how best to represent our hardware in dts.
> >>> For the gpio power supply, it can basically be any circuit that implements
> >>> a "fully charged" GPIO and a "disable ups" GPIO.
> >>>
> >>> We're using a circuit built around the LTC3350 (super capacitor ups chip):
> >>> We use this pin to indicate that our UPS is fully charged (once the input
> >>> is gone, it's not fully charged anymore):
> >>> PFO (pin 38): Power-Fail Status Output. This open-drain output is pulled
> >>> low when a power failure has occurred.
> >>>
> >>> For the "disable ups" GPIO, we have some external circuitry around the
> >>> LTC3350. I can't share the schematic, but it boils down to "disable usage
> >>> of ups" so that the device shuts down immediately when power is lost.
> >>>
> >>> We've implemented this in many of our devices, but first we're looking
> >>> at [1] and [2], which we also want to upstream the device trees for.
> >>> [1] https://www.beckhoff.com/en-en/products/ipc/embedded-pcs/cx9240-arm-r-cortex-r-a53/cx9240.html
> >>> [2] https://www.beckhoff.com/en-en/products/ipc/embedded-pcs/cx8200-arm-r-cortex-r-a53/cx8200.html
> >>>
> >>> For the LTC3350, there is a separate driver posted to the Linux kernel
> >>> mail list [3] by another devolper that we would like to use in the future,
> >>> but without this gpio, our circuit won't work.
> >>> [3] https://lore.kernel.org/all/?q=power%3A+supply%3A+ltc3350-charger
> >>
> >> This does not address my concerns at all. Read the previous comments -
> >> you are duplicating existing property.
> >
> > I think there is some misunderstanding. IIUIC you (Krzysztof) are
> > referencing the following existing gpios property without any
> > prefix?
> >
> >>  gpios:
> >>    maxItems: 1
> >>    description: GPIO indicating the charger presence
> >
> > This informs the operating system, that the charger has been plugged
> > in (so the GPIO is an input from operating system point of view).
> >
> > The work from Stefan is not about presence detection, but
> > controlling if the charging should happen at all (so the GPIO is an
> > output from operating system point of view). So that's two very
> > different things.
>
> So the gpios and charging status are input GPIOs and this is an output?
> If so this seems right, indeed.
>

Yes, Krzysztof, you see it right. Sebastian described the problem correctly from my point of view.

> >
> > Technically there is some overlap with another existing property:
> > charge-current-limit-gpios. I suppose a charger device limited to
> > 0 Microampere is effectively off. But I think its fair to have a
> > dedicated GPIO for explicit disabling.
> >
> > If my analysis of the situation is correct, the documentation seems
> > to be bad. Please suggest better wording :)

Which part of the documentation is being referred to: the binding, the commit message, or another section? 
Once clarified, I can suggest a better wording in this part of the documentation.

> > P.S.: binding and driver should be send in separate patches.
>

In the next version, I will split the binding and driver into two separate patches.

> Yeah, still all my comments should be addressed.
>

Krzysztof, in the bindings for 'gpio-charger.yaml' (Documentation/devicetree/bindings/power/supply/gpio-charger.yaml), 
is the property name 'enable-gpios' suitable for you, or should I rename it? 
If a rename is needed, which name makes the most sense to you for this function?

>
> Best regards,
> Krzysztof


Best regards,

Stefan

