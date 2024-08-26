Return-Path: <linux-pm+bounces-12877-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 272B795F09C
	for <lists+linux-pm@lfdr.de>; Mon, 26 Aug 2024 14:08:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3E941F23D29
	for <lists+linux-pm@lfdr.de>; Mon, 26 Aug 2024 12:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FFAD18D65A;
	Mon, 26 Aug 2024 12:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YoMNI9JN"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E0F1862B9
	for <linux-pm@vger.kernel.org>; Mon, 26 Aug 2024 12:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724673961; cv=none; b=DdWFfUVoGWdwfk1sYG5eaGRZ0FkY2VQz0gTMEy1NCn1Fu+MiL9//lg5k0TMlAygS03yiV0T0XxjVK5WsJsO0ke2aoIDTWsKS00EHS4YgQmoMOBp/j1TC0045ePlwTnROPXDGqpAoWzjWyVtmY2WpGW7I9DUrBuPHWGkj1WKfiWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724673961; c=relaxed/simple;
	bh=Fcy2G6PG7vXHR6Sg3oDL7cs8EvvwDoYJrT5MdvBcnIo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=iFyvD9QvBga9vWcPSja3qoISsFTe09fVUS2BUrKo9xW0gacrQkOJluNrnKlXUcrAm2ej9OvWhdm7pGcvvI1qeUY2InW9dGX737SIKM9PqIt8bHfW4Kjsb+rVf+mAeXHT2JzC6TY5hvFHbKqmLJZ11ef2ixv+hrNJFv04rHn9PcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YoMNI9JN; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724673958;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bplQPZquovtBOTv/+G4caO1NimffFmAf+IthOJubP1o=;
	b=YoMNI9JNSEVF9lH3aqJ9bT4wg9NXkyEdpbm6I9RQgJyXNFNKjoTlWfbpJ6pzpovBs9LC6v
	k5BWfCr1PAXtgBiuRMpPT6x/STgdRHMcdC3INUkVLFeJ5H8uPb7R3cJYflj76evz/m31UX
	I0Z3Toy/qs4Zp3JAUaTOR74o6lXVQOk=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-jeBuXtV_N0epQw46sevDCg-1; Mon, 26 Aug 2024 08:05:57 -0400
X-MC-Unique: jeBuXtV_N0epQw46sevDCg-1
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-5bee85b49c7so3459626a12.0
        for <linux-pm@vger.kernel.org>; Mon, 26 Aug 2024 05:05:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724673956; x=1725278756;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=bplQPZquovtBOTv/+G4caO1NimffFmAf+IthOJubP1o=;
        b=V/tWoX/Ih1S2Sf2uL1tvHiPNvr66SuU0a5tMYJF1WUobEe3V0DIbWRR91Xt3E+IY0V
         CpuA01peZqlnxvcwzG/Ubm7Yvx1pE+RBrOFhsfyx5qnP0sbCs+4Io79oqcVrezTcIiVS
         FxE7nIwIByOdVzibZjUTy1ZLR5UWGIT5S4EFRduP6rIOtCgPFbR4HDDBgzxGXOuyIhjJ
         1XXLLjUL2iYj1SxpEJYkX7+TxlIeq8kWsQGp6FxT7RmKSQdJWFhka5KJmC/XejkGSoL/
         GejgwCk4/g5vaTGZ3U7tdWUz3m6nl5ig5S0eerexKXI6gY8RKrR1kN5IhXV6RzpowxDH
         SfGQ==
X-Gm-Message-State: AOJu0YyWcUpdvHpFxCriV7PHvuYv554YlHWbX02fhw4LSTV/28q6Lb7Y
	svkaGMkxfd4K6Y7mQ02FvNI0aq1YNU1WAFplALlSmlHQ5HW44UaFfRsw0ExO/9HCbW/V5+neWle
	ipxdItRpKV8ypGtvIbCpJCIAYaYilIazYZPdOVYD62t2v+7pccbPyyg0zD0fKDatJKBk=
X-Received: by 2002:a05:6402:27d4:b0:5c0:ad76:f6bc with SMTP id 4fb4d7f45d1cf-5c0ad76f754mr1604971a12.33.1724673955769;
        Mon, 26 Aug 2024 05:05:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJFJEnQjFJs3vK2qwlTWB5SgmaLJA63vqVvLPjslVx+FKv4TLQZ4dr8T81H/5M7q4/ZODVgw==
X-Received: by 2002:a05:6402:27d4:b0:5c0:ad76:f6bc with SMTP id 4fb4d7f45d1cf-5c0ad76f754mr1604942a12.33.1724673955143;
        Mon, 26 Aug 2024 05:05:55 -0700 (PDT)
Received: from [10.40.98.157] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c044ddc6afsm5427632a12.14.2024.08.26.05.05.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Aug 2024 05:05:54 -0700 (PDT)
Message-ID: <49993a42-aa91-46bf-acef-4a089db4c2db@redhat.com>
Date: Mon, 26 Aug 2024 14:05:54 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Hans de Goede <hdegoede@redhat.com>
Subject: RFC: Extending charge_type power-supply property to show valid values
To: Sebastian Reichel <sre@kernel.org>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@weissschuh.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, Jelle van der Waa <jelle@vdwaa.nl>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

<resend with Thomas who implemented the charge-behavior code added to the Cc>

Hi Sebastian,

Jelle (in the Cc) is looking into adding a UI to GNOME to allow users to
enable battery long-life mode. The initial plan was to use the charge
start and stop thresholds but not all laptop models support these,
some only have a single toggle to turn long-life mode on/off.

At first look it seems that charge_type is the right userspace API to use
for these single toggle only laptop models, offering "Standard" and
"Long Life" as valid options.

However we don't want userspace to have to write charge_type just to
find out which values are supported.

My proposal for this is to have a new POWER_SUPPLY_PROP_CHARGE_TYPES
properties which behaves like USB_TYPE / CHARGE_BEHAVIOR, e.g. :

[hans@x1 linux]$ cat /sys/class/power_supply/ucsi-source-psy-USBC000\:001/usb_type 
[C] PD PD_PPS

The idea would be to copy the charge_behavior model and add
a charge_types bitmask to struct power_supply_desc mirroring
the u8 charge_behaviours; bitmask. This will also allow re-using
power_supply_charge_behaviour_show() turning it into a generic
show function for usb_type / charge_behavior style properties.

Other then having the usb_type / charge_behavior style show()
output the new charge_types which I'm suggesting would behave
exactly the same as the old charge_type and drivers can use the
same code paths to implement both.  To get support for the new
charge_types drivers just need to set a power_supply_desc.charge_types
bitmap and add POWER_SUPPLY_PROP_CHARGE_TYPES to their list of
supported properties.

The idea is for charge_types to basically superseed charge_type
offering the same functionality while advertising which values
are valid for writing, while keeping charge_type around for
backward compatibility.

If this sounds good to you I can write a patch-set implementing
the suggestion, + converting one or 2 drivers which already
support writing charge_type atm.

Regards,

Hans


