Return-Path: <linux-pm+bounces-24436-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B4B9A6CF37
	for <lists+linux-pm@lfdr.de>; Sun, 23 Mar 2025 13:36:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C914D3B4ED2
	for <lists+linux-pm@lfdr.de>; Sun, 23 Mar 2025 12:36:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5D9017D2;
	Sun, 23 Mar 2025 12:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="A5GWs8ZZ"
X-Original-To: linux-pm@vger.kernel.org
Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CDE623;
	Sun, 23 Mar 2025 12:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742733376; cv=none; b=K28RyGGbIDv+ZV2f0EgxijTTT1l3zdi5RGBLi40k5aNezyQeHHPMLQqg6+JobfTOZbFQ0NgFyVGNElKZPudgewILWWlVTK+DiabCsQvz/Ge/P5+SoXBvXtSbcWfOWzm0AI44yx6+/EeQG/qqMpsfh6MrMii77IqidDQmMHRvlpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742733376; c=relaxed/simple;
	bh=cKnmb/AvRSbteASF5DT+ty/21aXMVv19VOgr9QzltMs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cP5NurDTI1MoL5dqt7rmnbe3Bf541yaSzqpKVUzPoEpynG1UzgLyXYZLng7p7zvLaH0dzmH1zLBu3hZmS78uD1gr7M4dX5Cz9YVqW/4Dexva5YAZ/DF5IdkSvetHeWoVSoUcNP+dEl9I1WgtGxPfSFH/Va0gkwcDj1/m4NjhGqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=A5GWs8ZZ; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4ZLFzD1Dqjzm0ytd;
	Sun, 23 Mar 2025 12:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1742733366; x=1745325367; bh=5tj9iO/ST31ro8NtZXZ+WYzO
	2KM6kAX7w53AjZ7Mg0A=; b=A5GWs8ZZ3fEVqp/IdS6gJ5ndHfUdUWDGXjSVadOm
	ULUDNHfTeBg63zQOC/FYqWafLEyyAuM3Acaon/qlwAwmofjkUL5leSzGQEXN4bfp
	WeJcisPT0KAPbeKZdB/55HMrN8u5xr/jwzLKUE+ozDsWc3cCxJOnvCU7Pgx2VhdT
	5acN3hB2uASO90SyDR+xECFYnU7+e+XAhi/WOOc8UV5nhrk8hNZ7pYayDN7zx8FL
	ol/sdTCpYOQjem7jkiWyVzuQVGtdBVJkqMjD/+1LXwYaJrpJm28WeIN4ToORgdA4
	/dIFh62l4lQ0i1AeUXXBP2LnlNa5+p1Aqie5zaD/JRTR1Q==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id dO7ADQ8zc2Rh; Sun, 23 Mar 2025 12:36:06 +0000 (UTC)
Received: from [10.46.23.145] (unknown [156.39.10.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4ZLFz56LcHzm0pKT;
	Sun, 23 Mar 2025 12:36:00 +0000 (UTC)
Message-ID: <1ae51ccc-66cc-4551-b649-2f5883e2f5a2@acm.org>
Date: Sun, 23 Mar 2025 05:35:59 -0700
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] cpuidle: psd: add power sleep demotion prevention for
 fast I/O devices
To: "King, Colin" <colin.king@intel.com>,
 Christian Loehle <christian.loehle@arm.com>, Jens Axboe <axboe@kernel.dk>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <33882f284ac6e6d1ec766ca4bb2f3b88@intel.com>
 <f18607ca-30dc-43de-be77-fec69968aeec@arm.com>
 <SJ2PR11MB7670F63C7052C88637D305DF8DDF2@SJ2PR11MB7670.namprd11.prod.outlook.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <SJ2PR11MB7670F63C7052C88637D305DF8DDF2@SJ2PR11MB7670.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/17/25 3:03 AM, King, Colin wrote:
> This code is optional, one can enable it or disable it via the config option. Also,
> even when it is built-in one can disable it by writing 0 to the sysfs file
>    /sys/devices/system/cpu/cpuidle/psd_cpu_lat_timeout_ms

I'm not sure we need even more configuration knobs in sysfs. How are
users expected to find this configuration option? How should they
decide whether to enable or to disable it?

Please take a look at this proposal and let me know whether this would
solve the issue that you are looking into: "[LSF/MM/BPF Topic] Energy-
Efficient I/O" (https://lore.kernel.org/linux-block/ad1018b6-7c0b-4d70-
b845-c869287d3cf3@acm.org/). The only disadvantage of this approach
compared to the cpuidle patch is that it requires RPM (runtime power
management) to be enabled. Maybe I should look into modifying the
approach such that it does not rely on RPM.

Thanks,

Bart.

