Return-Path: <linux-pm+bounces-13866-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E6FD597093D
	for <lists+linux-pm@lfdr.de>; Sun,  8 Sep 2024 20:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 586CFB2106D
	for <lists+linux-pm@lfdr.de>; Sun,  8 Sep 2024 18:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40FEC17624F;
	Sun,  8 Sep 2024 18:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CDD/x+Fx"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234C7A2D
	for <linux-pm@vger.kernel.org>; Sun,  8 Sep 2024 18:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725820986; cv=none; b=U12kJXTDVSlLZkRA8xIdOHec6dFtRknSWF5YQy8rrTkYhArNPrAkvtZwdMvCyjJXK4cFYfhk4VAStkRXbj6oqSZ9LEQ0hr41wke9b6jR0eJ+qUyJi04jcF6K/ftcyhL0chMmB9YfmgvFlydrT3WqbC6yDcNGqfXqE4RBS1Fu/bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725820986; c=relaxed/simple;
	bh=1p8b+foe+5zSA6mIPBnUYMjKnd5JStufjtTilxx/UlM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cCHi57wW8QpYa8Y0YAkZMRFKr18G6RKFzGCSL0QCZqYjlmTYN31de7DWtO20eitytCxshiT2Wiatqde/yeI/FCln/MhnB3jkNqEgAtskP0FrCr64aMDb3cvJRr1dZSKeGzV6gmHeR68nFa9rhYr2DqIdM3oK/3j9icU0Ag3Aqw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CDD/x+Fx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725820983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u7Q4IYt8TYjvq5FDSA3nDgXNi+6J2TuajIjT1dm3XYI=;
	b=CDD/x+FxjtysuECx6etNmgGXlRn9nBkax66WBvoQaZM5CL1B8kFrivXgsEdU4cpSTOZrBp
	vkaJVCf9/6UTIkVWkZA4jzttPf+9GHCB3Ohjf62v31gF4jrSoKbPbV8XYhvmmAPcTJmJvA
	FcKVUerpWebxPhijplg6U+DczHrsFKY=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-264-KYGRrl5mP4qf7JADVAOuKQ-1; Sun, 08 Sep 2024 14:43:01 -0400
X-MC-Unique: KYGRrl5mP4qf7JADVAOuKQ-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2f4f66fd878so28601051fa.1
        for <linux-pm@vger.kernel.org>; Sun, 08 Sep 2024 11:43:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725820980; x=1726425780;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=u7Q4IYt8TYjvq5FDSA3nDgXNi+6J2TuajIjT1dm3XYI=;
        b=YJHDpsYlYx4Nyisjk+TSsZ+rJf1e7UGVNORNtgJ54InYe5YcbaP8vpTgLaxTXTSijr
         yY8q0sgEM/oy3gNgefBLAh8G7GQfWVqJuc0w7bxOpFoQbOht2AHG55djLExDw2KKo6NK
         GTbjAz2E4aFBJd0kUv5sbARw+xr+qEXY7kG6lbzRFbNUB1EmnNsxcsGBEDL16+ZpK2sZ
         B7OO2EXJ9PDBbSBPTJKNdcdcuIwIPy+pSzeDYUaqQobgzixsVxPmHnE1aNJ20K31dgw2
         Lr209j3G0Vn7FbOiIjfGtuNzOHcQhm27QfR5D3kukEwHoC9nU5wnmZCaDqRf19gbVYTM
         jLgA==
X-Forwarded-Encrypted: i=1; AJvYcCV9oevKeyVvZPqlG2AsiN2Hbszlwq/pdrZnESiJAN1f6AQn5QgfeN0wxNw1VFdonfFtu/Lb6dQZfw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg+u7GaNiZcwtQlDkB+3HM1Fkd7NeMhGVgTQ+iI2ovN/eI+qAe
	IrU6cdI30UrGEnP1xB9+XuzB/OHpm03ILQijkrQXWLQYN03Eok+wPSymYb2JCfi/KTf4/mapK8z
	+aL/8Nb0fCc2iOIBvElAIxSBmpJrAeguXfQqTrZFlBNeFbeFqYKEl8Sdm
X-Received: by 2002:a05:6512:b24:b0:535:3d15:e718 with SMTP id 2adb3069b0e04-536587fcf0fmr6296959e87.50.1725820980018;
        Sun, 08 Sep 2024 11:43:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExKf6NlTtamrY+zpyGl4ui6wwN9C10Nyg/YqaaNvveGw3ZvAj/vw77tnLzYR6hOaCBFeXBVw==
X-Received: by 2002:a05:6512:b24:b0:535:3d15:e718 with SMTP id 2adb3069b0e04-536587fcf0fmr6296945e87.50.1725820979394;
        Sun, 08 Sep 2024 11:42:59 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a8d25d65396sm235510566b.217.2024.09.08.11.42.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Sep 2024 11:42:58 -0700 (PDT)
Message-ID: <9803c227-13bb-4b35-a7a9-089c8437b78d@redhat.com>
Date: Sun, 8 Sep 2024 20:42:58 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6.11 regression fix] power: supply: sysfs: Revert use
 power_supply_property_is_writeable()
To: =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
References: <20240908144414.82887-1-hdegoede@redhat.com>
 <de97c24e-85b2-4196-80da-5718075c900b@t-8ch.de>
 <44c3d02a-cab2-4d51-86cf-600fdf19f1a4@redhat.com>
 <b54d7389-1a7e-4102-9f21-48ca83f5b7d2@t-8ch.de>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <b54d7389-1a7e-4102-9f21-48ca83f5b7d2@t-8ch.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 9/8/24 7:28 PM, Thomas Weißschuh wrote:
> On 2024-09-08 18:38:21+0000, Hans de Goede wrote:
>> Hi,
>>
>> On 9/8/24 4:52 PM, Thomas Weißschuh wrote:
>>> Hi Hans,
>>>
>>> On 2024-09-08 16:44:14+0000, Hans de Goede wrote:
>>>> power_supply_property_is_writeable() contains the following check:
>>>>
>>>>         if (atomic_read(&psy->use_cnt) <= 0 ||
>>>>                         !psy->desc->property_is_writeable)
>>>>                 return -ENODEV;
>>>>
>>>> psy->use_cnt gets initialized to 0 and is incremented by
>>>> __power_supply_register() after it calls device_add(); and thus after
>>>> the driver core calls power_supply_attr_is_visible() to get the attr's
>>>> permissions.
>>>>
>>>> So when power_supply_attr_is_visible() runs psy->use_cnt is 0 failing
>>>> the above check. This is causing all the attributes to have permissions
>>>> of 444 even those which should be writable.
>>>>
>>>> Move back to manually calling psy->desc->property_is_writeable() without
>>>> the psy->use_cnt check to fix this.
>>>
>>> Thanks for the fix!
>>>
>>> OTOH the whole power_supply_attr_is_visible() is completely unused
>>> outisde of the psy core. So instead we could unexport it, drop the use_cnt
>>> check and use it again.
>>> (All of this as part of the psy extension series, for now your revert
>>> should be used)
>>>
>>> What do you think?
>>
>> So I took a look at other users of power_supply_attr_is_visible() and
>> the only other user is power_supply_hwmon_is_visible() which suffers
>> from the exact same problem.
>>
>> NACK.
>>
>> So self-nack for this fix. It is better to drop the use_cnt check
>> from power_supply_property_is_writeable() altogether since currently
>> all hwmon attributes are always 0444 too. I checked with a max170xx_battery
>> where /sys/class/hwmon/hwmon5/temp1_min_alarm should be 0644, but
>> until I fix power_supply_property_is_writeable() it is 0444.
> 
> IMO it should also be unexported and renamed to
> psy_property_is_writeable() to signify that it's internal to the psy
> core.

Agreed, but that is something for a follow-up patch.

Feel free to add a patch for that to the next version of
your psy extension series :)

Regards,

Hans




