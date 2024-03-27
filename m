Return-Path: <linux-pm+bounces-5490-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 865F188DB6D
	for <lists+linux-pm@lfdr.de>; Wed, 27 Mar 2024 11:44:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E2232B24914
	for <lists+linux-pm@lfdr.de>; Wed, 27 Mar 2024 10:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F3C94F1E3;
	Wed, 27 Mar 2024 10:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pv3oo70V"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D07CF1E88D
	for <linux-pm@vger.kernel.org>; Wed, 27 Mar 2024 10:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711536287; cv=none; b=XTxbD/aZrUCnvWQIwHfOfgyyA8jf2/euto3ZKq3eeEGlVVEGVGw4w5EDtE/8Dpr0gSkxgxCXEbTR+05ahQ3eqSGJuBMUHD6JIlKw2gS/GtERSEVDYB06tqTxqYEcyWz1Mng9mZmxC870x+FaT05ilW4OgpEx16iXAhtYFfQuTCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711536287; c=relaxed/simple;
	bh=lmuk6TusSQkOrFRgEF6krdSYo1Ma9u5yHt+tzmVoVLA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=t0ZcvV+/mlet4alfuaGUc6iWDEk7xB3CQCW1BZWT9RvYMO+9wUiEMm3tKIQ0t8AVTWeL5X4NZhYLJFe6P/v2XFegjDIdRki/lUuXbfC9y4feuFNTCK59CFg6+16xo9uS2lrHcNIPGFRx/PGf/HRe7B1oPI5yIlOMAx3obKRGg14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Pv3oo70V; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711536284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ez+DfU/pKmOevZsWMVq7Pe8YJPQsmb9b6xRp3Rz6UTM=;
	b=Pv3oo70V2O05PBTsNUtms7KTu5emPTgZLHz3zSz6fkzV4d22oI7o1avq5Tdg/SFkIuOryw
	CleHD3j52ICIyDYMDd/SPOMuXDVlNms6I1bR1nibTAh7fGam86MNU7UAtHIEdPQzz2IcEu
	ogxj4smdB0lGy5WTg+GQDwKxDVUVwsA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-101-VcUCi15tPUKg4ROlcl_kfg-1; Wed, 27 Mar 2024 06:44:43 -0400
X-MC-Unique: VcUCi15tPUKg4ROlcl_kfg-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-56bf2dbbaadso2863692a12.1
        for <linux-pm@vger.kernel.org>; Wed, 27 Mar 2024 03:44:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711536282; x=1712141082;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ez+DfU/pKmOevZsWMVq7Pe8YJPQsmb9b6xRp3Rz6UTM=;
        b=i782w5YDBTu7ayIttZj++6qRPJqp8CMcTKZWokIlV62k5VWPzWsQPiYoN8DGPTqotN
         8yMlhpHB3cR64cv3Yk/ke7o7KR0Whq0iSIXW4t/s/vDA9Pi+DOxGzh9OVM7x2xN+rXWU
         BWl4stZsNpBD8thNYwi+gLl4TnqMg5KO+vks3nbtD+8k64KkQjJIJz4pUBt0ik9bKzAT
         eiYOfR+BdJrztzNTkyVvgBV1b482zXzu3vdKxBji3+CZRz5aP99T1SRilAdJ9MqZMDho
         XMSd4u/2GefA+lOW/U3bf44N7Mk/FEmf0LgFzFIUXPvDyMaW/ADSEonNiNbqltMM/vAC
         3vjA==
X-Gm-Message-State: AOJu0YxKdZj5pqPN1zsFRa9KlSTU8zjnVbfnDXZQ+Vj0uhgdffwpX3J+
	4oFOcbV0iaa6FaYPs2ydv02KOoHrJcMvE9Q8sOfxTKM+72AClKwDEcX5dQDPhDD3GCnKNrbXW5R
	tT+oot455JVNP/K5m6an4iube8q8/sbNbbsfy6OI0hl8u1unA5jEmoIqQXfoQ2IFp
X-Received: by 2002:a17:906:4ad3:b0:a46:7c9c:10d0 with SMTP id u19-20020a1709064ad300b00a467c9c10d0mr547360ejt.23.1711536282129;
        Wed, 27 Mar 2024 03:44:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIQUj3lLHZP90JkeIOIlrhnz5bf74xtLGccdVai8P8RbXYh6J6BFonG2OnDbzqpCngEMdpnQ==
X-Received: by 2002:a17:906:4ad3:b0:a46:7c9c:10d0 with SMTP id u19-20020a1709064ad300b00a467c9c10d0mr547347ejt.23.1711536281813;
        Wed, 27 Mar 2024 03:44:41 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id u17-20020a17090663d100b00a468bcde79bsm5311110ejk.109.2024.03.27.03.44.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 03:44:41 -0700 (PDT)
Message-ID: <9fe3d7a6-3b34-4c96-bd9f-510b41f9ab0d@redhat.com>
Date: Wed, 27 Mar 2024 11:44:41 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] power: supply: test-power: implement charge_behaviour
 property
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
To: Sebastian Reichel <sebastian.reichel@collabora.com>,
 Sebastian Reichel <sre@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240306-power_supply-charge_behaviour_prop-v3-1-d04cf1f5f0af@weissschuh.net>
 <171148264419.185695.14027540198251584096.b4-ty@collabora.com>
 <6f0761a6-5f49-42e2-9b79-3e04c9d259a4@redhat.com>
In-Reply-To: <6f0761a6-5f49-42e2-9b79-3e04c9d259a4@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 3/27/24 11:36 AM, Hans de Goede wrote:
> Hi Sebastian,
> 
> On 3/26/24 8:50 PM, Sebastian Reichel wrote:
>>
>> On Wed, 06 Mar 2024 20:37:04 +0100, Thomas Weißschuh wrote:
>>> To validate the special formatting of the "charge_behaviour" sysfs
>>> property add it to the example driver.
>>>
>>>
>>
>> Applied, thanks!
>>
>> [1/1] power: supply: test-power: implement charge_behaviour property
>>       commit: 070c1470ae24317e7b19bd3882b300b6d69922a4
> 
> Does this mean that you've also applied patches 1-3 of:
> "[PATCH v2 0/4] power: supply: core: align charge_behaviour format with docs" ?
> 
> Because this is a new version of 4/4 of that series and I think
> that the new test may depend on the fixes from patches 1-3
> of that series (which I'm reviewing now).

Ok, I have some not entirely trivial comments on patch 3/4 of that series.
I guess you (Sebastian) could address those while merging, or wait for
a v3 of the series.

Regards,

Hans


