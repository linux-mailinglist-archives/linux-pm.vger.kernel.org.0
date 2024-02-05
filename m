Return-Path: <linux-pm+bounces-3381-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62BAD849728
	for <lists+linux-pm@lfdr.de>; Mon,  5 Feb 2024 11:00:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 957841C226D6
	for <lists+linux-pm@lfdr.de>; Mon,  5 Feb 2024 10:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C123412B87;
	Mon,  5 Feb 2024 10:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CWVzxJ1A"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AB3512E71
	for <linux-pm@vger.kernel.org>; Mon,  5 Feb 2024 10:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707127209; cv=none; b=J/abKnCSHZxZ1D9j2yWSjwQgDUcozZ1xzYCMyFxWj9cTsYMf+4Ke5MhLf9pZReD5h7AJdKg93MnoKjx5yAttvFnSI3cQn1t9zi1KF6g3Np1HOfh0in6u08nH2lMb5mdsW5cM7YqrRC8c4LSyi4V5LVRYT4XFR3Xgxn+iXu0uwv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707127209; c=relaxed/simple;
	bh=0zwGLQozIm1xLIUb+JT1QR0nH+Sj7un9j5w6FlqwRqA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L8utjQKyckNmjUvp2GUak5l5Am5YbiK3iJoZuuLXP24fGZaWQxfzQFmHLRC9O2b+VHyx/aKCsgAXsFkUqGN/YD9kAszTF+srAD1MMXItTAa7pmjL0/xEMfZQitsls4YGQEylc6c23OJImpy4LYTvyMxU6OqeQnpJcjg1ySXDLjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CWVzxJ1A; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707127207;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y1Gn5QY0RzFz/c12Z/qyBnZZspPbZJTFIJYfZUyz5g0=;
	b=CWVzxJ1AVY72xH3rVL3Dl3jHSmv3PE4wQ8kYCfG5up20+kegL01Odrtx0I/32OYwR07aFO
	7WZZSClBPyVFXI0MubUoDyA6miHUKXusEPh27F7TR64HTjqSo3mlSgrSSA5dNgNtwEcQnc
	55y26klmOyc3SilC7T/sAv+lR9WNlBI=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-LspCnZyCPFSiKLyMhNxn9g-1; Mon, 05 Feb 2024 05:00:03 -0500
X-MC-Unique: LspCnZyCPFSiKLyMhNxn9g-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a2bffe437b5so275026966b.1
        for <linux-pm@vger.kernel.org>; Mon, 05 Feb 2024 02:00:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707127202; x=1707732002;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y1Gn5QY0RzFz/c12Z/qyBnZZspPbZJTFIJYfZUyz5g0=;
        b=M2pjJPt8hh2S6KhsnG+aXOH/eQS5j+25L8p5ww9+cEAawLpzd7SeVkAVmeGLVzGLZ5
         oMSpaYfFnQNekaVczPUBSKfAl3u629MzG0HBYUD0tbwrJIFvBDP1DnFafU8/l4NcQOV2
         m2cbmj81z8+VKiMaB+a5H/TD7B+/rs6QsvlIVVc5GS7xHKhIsRq7cA0i+kI6RbaACsQN
         ha4sqqth3gwp+GWF7zXKyo54lEe6dy+FdOhuTAuhj7/3M6dr5BYRaGJ6Pk6IiG71BIjh
         sWZ2otDVt5lMCeBqfjJo3GjAVl5Gp66k/b5a7StZ58xmhpHDG5KDQA0+1yVqvGLPTnUv
         Hlgg==
X-Gm-Message-State: AOJu0Yx5BwLQoiAoFWGgvY8GMJ/ELutUjDSxQvXzjbWRXbXihEg6IuuB
	eGpR8aFZCZK5JDGLweOwF/uAcIzdcyu5n8oAgCDJiRc4dCs9QS7plHZPbi4hhzNgitEDYrbQimv
	0ZXWtS9X7aeiFo6hs7kndpdcJ03cR8FBTcuNW+4DzL6Pl1yc/8H4cKLh2
X-Received: by 2002:a17:906:6c9a:b0:a37:7e9c:17ea with SMTP id s26-20020a1709066c9a00b00a377e9c17eamr2558744ejr.12.1707127202769;
        Mon, 05 Feb 2024 02:00:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFDasoEfxSl3kUGHu4aAoww/p36CcrrtEFIiFCNTq9O7sX/0D5DLggoumkHWtoeIrvXiXZpyQ==
X-Received: by 2002:a17:906:6c9a:b0:a37:7e9c:17ea with SMTP id s26-20020a1709066c9a00b00a377e9c17eamr2558726ejr.12.1707127202454;
        Mon, 05 Feb 2024 02:00:02 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXHkc55LLSsMQmfs5K3PghfD0W5Y6o+ipTZQwDlhI1YPtrAzL/9GF/wwI4wDRsnZ7N0EybIZobE6yyZV2QDLJ7xLHaFKjf1bXNJ5zfk50Yqh6Sh36nzquGVd62Tf95f1E3nFAD4YsvTwAisbkSx6SDQzabBCkMYuSM+ml756DyN1OdwNqPTmYBifwido3Ab2PdlMlD4Nw==
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a20-20020a170906671400b00a34d0a865ecsm4078151ejp.163.2024.02.05.02.00.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Feb 2024 02:00:01 -0800 (PST)
Message-ID: <2f244f9f-8796-4cad-8bf8-d0c3411588c1@redhat.com>
Date: Mon, 5 Feb 2024 11:00:01 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] power: supply: mm8013: implement
 POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR_AVAILABLE
Content-Language: en-US, nl
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 Sebastian Reichel <sre@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 Sebastian Reichel <sebastian.reichel@collabora.com>
References: <20240204-power_supply-charge_behaviour_prop-v1-0-06a20c958f96@weissschuh.net>
 <20240204-power_supply-charge_behaviour_prop-v1-3-06a20c958f96@weissschuh.net>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20240204-power_supply-charge_behaviour_prop-v1-3-06a20c958f96@weissschuh.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 2/4/24 18:26, Thomas Weißschuh wrote:
> The sysfs is documented to report both the current and all available
> behaviours. For this POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR_AVAILABLE needs
> to be implemented.
> 
> Note that this changes the format of the sysfs file
> (to the documented format):
> 
> Before: "auto"
> After:  "[auto] inhibit-charge"
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>

Changing userspace API like this is never ideal, but given how
new the mm8013 driver is and that this brings things inline
with the docs I think that this should be fine:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans




> ---
>  drivers/power/supply/mm8013.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/power/supply/mm8013.c b/drivers/power/supply/mm8013.c
> index caa272b03564..695df8bd6cb0 100644
> --- a/drivers/power/supply/mm8013.c
> +++ b/drivers/power/supply/mm8013.c
> @@ -72,6 +72,7 @@ static int mm8013_checkdevice(struct mm8013_chip *chip)
>  static enum power_supply_property mm8013_battery_props[] = {
>  	POWER_SUPPLY_PROP_CAPACITY,
>  	POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR,
> +	POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR_AVAILABLE,
>  	POWER_SUPPLY_PROP_CHARGE_FULL,
>  	POWER_SUPPLY_PROP_CHARGE_FULL_DESIGN,
>  	POWER_SUPPLY_PROP_CHARGE_NOW,
> @@ -113,6 +114,10 @@ static int mm8013_get_property(struct power_supply *psy,
>  		else
>  			val->intval = POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO;
>  		break;
> +	case POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR_AVAILABLE:
> +		val->intval = BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_AUTO)
> +			    | BIT(POWER_SUPPLY_CHARGE_BEHAVIOUR_INHIBIT_CHARGE);
> +		break;
>  	case POWER_SUPPLY_PROP_CHARGE_FULL:
>  		ret = regmap_read(chip->regmap, REG_FULL_CHARGE_CAPACITY, &regval);
>  		if (ret < 0)
> 


