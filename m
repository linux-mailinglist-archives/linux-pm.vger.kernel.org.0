Return-Path: <linux-pm+bounces-12876-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E6D95F05F
	for <lists+linux-pm@lfdr.de>; Mon, 26 Aug 2024 14:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDB711F2181D
	for <lists+linux-pm@lfdr.de>; Mon, 26 Aug 2024 12:04:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A0FD158D79;
	Mon, 26 Aug 2024 12:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eIG0FMBC"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD50078C73
	for <linux-pm@vger.kernel.org>; Mon, 26 Aug 2024 12:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724673886; cv=none; b=Icp78/VjhdmHx/sNiKg+hcxj8DMu3tH+0khLOqWQJ67I8fiMsSUY8dtyghfNqd3psgMJJ13iqPaPqnoq0heXjSJ8mT0mYywMauBdTD1FIrXaqzjKZIXW6grqw8IufUgtDnLYzxvymiUu6PRe/+sot4gyQsdUWbXjgZ6m7Rd+GF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724673886; c=relaxed/simple;
	bh=+LqDRYpJSbREFNO3JdZNLM6ZFjXI/PEK0cLopfkW1l8=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=bHnBycF2BRIX+WD2T9jFnb+0Bp6tIuOpBtDt8eIR5+Tj80exoxb2WGLER8bpGc0YWdmAoCzKEAvjXOurYWTj+EC3PJSdms/qlwweEhhg/Fpa02mNLUt+m4ZjhWKGLj/U761dp/5hVLSwhNMlanVDuxWW8j0GOSoRA0GWwPMYWWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eIG0FMBC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724673883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=vsltA9sNVyhNplX4ouF7J/Il4KV1kBvGQZWvHwO4JPo=;
	b=eIG0FMBCcTedpPH3g5YKZuqTBv1J/GjZdJ1jD4AJbRZuDf4V/rhlkNa1bslOTAiqivRGX3
	focTORAsCyPv3tL4pXggYLtd6xV2jxqW0f8cGzKMYzShLMmpAzCUrqL9hw2C7UocICioA0
	Qazap4INQXx5r3jIZrwjl+tSTzjK0+A=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-w81hpFYVPP6Wz63BC-SngA-1; Mon, 26 Aug 2024 08:04:42 -0400
X-MC-Unique: w81hpFYVPP6Wz63BC-SngA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a868403dbdeso307014666b.1
        for <linux-pm@vger.kernel.org>; Mon, 26 Aug 2024 05:04:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724673881; x=1725278681;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vsltA9sNVyhNplX4ouF7J/Il4KV1kBvGQZWvHwO4JPo=;
        b=B4+VcYSU3EUHwGc5yxD+YlqDYtv3CmxbOQrr5DCM31XTVm9eg8tXhki1ZvQH6BqmwE
         /rrLLWXBqCIgiirWjC/Fvcwp/iW8H6qDgKD+zqMzY5+s0AB1/2svwGq/eWq5mnn0WM5w
         LhOkZ/W5gpGQ8zeqc3gPwVyOphl2RQYcyYc+6Lpq7Dwa0vAaa0t4RJKZNx0wogd8U1In
         oE21BTX+32Hxbc8WxDLWPDypXlw8/WOvUeXhEIIv6512lql0JHafM/xQgEJaJD+ZS9Ql
         VvLVrVZ7uY+HI87CvlIh5wkDHVnGhQrkR0eGt931J5CRgp3Yr5/rbKCzBpRUxB9cLloK
         bBOA==
X-Gm-Message-State: AOJu0YytL8LqFdPEX1zt968Z6ygUjsWGehKCqfXu71qxQEyEsSa/L0gu
	VHHNwxYpyVnkgTM0hlwLLDyJ4E8VJkhSYA/V83YbnaK4FoGksBlNiyQ4SyhKwR0JbwOxH+wCz/u
	KWZ7Rr6bzrYACkJmdbmbzi5KHQBSKDYnXFT5SsobNfRfEm0wr0OkS0deB0EfVdA+hR1E=
X-Received: by 2002:a17:907:e253:b0:a7a:b73f:7584 with SMTP id a640c23a62f3a-a86a52de58dmr697667266b.34.1724673880834;
        Mon, 26 Aug 2024 05:04:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFCFGqDeRfvb2P763LGTfXtHuBjg/xNPSRKv7tXZ5dvM1Pw12PhquSQ+qhn49JkvfgTiAmpHA==
X-Received: by 2002:a17:907:e253:b0:a7a:b73f:7584 with SMTP id a640c23a62f3a-a86a52de58dmr697665266b.34.1724673880361;
        Mon, 26 Aug 2024 05:04:40 -0700 (PDT)
Received: from [10.40.98.157] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f223596sm651125866b.28.2024.08.26.05.04.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Aug 2024 05:04:39 -0700 (PDT)
Message-ID: <74aae97b-530f-4578-9dc8-d9b2100b6c64@redhat.com>
Date: Mon, 26 Aug 2024 14:04:39 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Sebastian Reichel <sre@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, Jelle van der Waa <jelle@vdwaa.nl>
From: Hans de Goede <hdegoede@redhat.com>
Subject: RFC: Extending charge_type power-supply property to show valid values
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

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


