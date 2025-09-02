Return-Path: <linux-pm+bounces-33630-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E484B3FDAE
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 13:21:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 159712C4866
	for <lists+linux-pm@lfdr.de>; Tue,  2 Sep 2025 11:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DBE32E92C5;
	Tue,  2 Sep 2025 11:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="KdXe8w0J"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.15.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A6B274FCB;
	Tue,  2 Sep 2025 11:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756812112; cv=none; b=mJdP7Z9FIyfx7aRyFoyhyvdQoVnh2FxeMzFkuUOxzAq6YAi97/qiZzPMIgP6eQYKgRW2n20xrmWeEMa6HluyvFkFHIyab6Djrn9GJT/0+RjCKazKpfMA3tvJXtuzqW315i5DgCJQvIMTsRoFde47PN1OZ0ap+xW6QKUVBtUIwlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756812112; c=relaxed/simple;
	bh=4NAU2fFUN4oBOnGRtO210Gil1SgW+nftUGXv/Nci2NM=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=pc+I8Z0eT9p+8dQcb1hx/Yj5fbgoSt5XBsgRCwR1chP5aEwr7HmU6q/GgiddtU34BJ+mNd12tza43Ef5wUXUDWGeSWkL/Z+uvOToVU6L5PH+sqd7ZUY8X3ZBt/9FnJblYG638oiW98HAub8c6ApgsKquFhdiB72HwQiHtkJP590=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=KdXe8w0J; arc=none smtp.client-ip=212.227.15.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1756812101; x=1757416901; i=markus.elfring@web.de;
	bh=31kywrcRGSrYQdI1SUL49Ta8jxlih29MoES76Pc5fVs=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=KdXe8w0Jpu5vNzEbeiqSBdpoU3/BS5jSzZX+TYqScdiTzkm/VPTsyHz7QXnv3f5g
	 W6bh8/SAgJGaHvTAIRU0oxYw07VwEgpGkdDV/IhtRcBg6HkXYA9PhfwMB1++tyfXZ
	 oQ14DrqgTztzc5C5zE1NPd2ySNrFI4VyZn0JHh5Vdmdg67VigsWTOwXG2R+sbhClu
	 /imlJC8WOX5W8i1tonOeOqm9IzgfkbY5WXyNsqzNJmNqUFbNApwN0bbAeqnDoTE+S
	 wU/pLqqPEC31Fv6oULYBo8+AI+JpGi0Agvw3eaT3DsUNTqSRJOqv6ey0dQAKVoo4E
	 FLvLVr0j8qj1vHxYtA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.184]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MnG2C-1uACyP1sSC-00lGnm; Tue, 02
 Sep 2025 13:21:41 +0200
Message-ID: <6b83923f-ce62-49be-b211-de9e518d3d6e@web.de>
Date: Tue, 2 Sep 2025 13:21:40 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Miaoqian Lin <linmq006@gmail.com>, linux-pm@vger.kernel.org
Cc: stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>
References: <20250902070215.2383320-1-linmq006@gmail.com>
Subject: Re: [PATCH] cpufreq: nforce2: fix PCI device reference leaks in
 nforce2_fsb_read
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250902070215.2383320-1-linmq006@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:5L0MIjgb+4fdwiTiT1/W/GbO9MTgpaaQcU1NaDImIFVPmx70D3B
 GxkmXdhaPvhVjRGAQ99vVH3MwZzt7bikVQ9OioAgsWv+DCLQ/LmzkSXn3XZxRXsWB59Zk63
 LF8G9mqbaipXgTVweLFT3vKqTW9retYzTeRZdj6F+iPEWXvLtfrU8ZChzYalUSkEwsz//au
 8Vz9sBPWFqxjIk5l0cM1A==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:dex3zIVDKGM=;zlo///4GpSatL5Vhz4mb+WlwwQw
 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

> Add missing pci_dev_put() calls to release device references
> obtained via pci_get_subsys().

* Would you like to complete the object clean-up by using a goto chain?

* How do you think about to increase the application of scope-based resource management?
  https://elixir.bootlin.com/linux/v6.17-rc4/source/include/linux/pci.h#L1208


Regards,
Markus

