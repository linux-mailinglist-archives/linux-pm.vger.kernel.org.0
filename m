Return-Path: <linux-pm+bounces-16391-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 23A879AEA36
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 17:20:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 553061C22AA6
	for <lists+linux-pm@lfdr.de>; Thu, 24 Oct 2024 15:20:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3DA41E32CF;
	Thu, 24 Oct 2024 15:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="LS/+8UvI"
X-Original-To: linux-pm@vger.kernel.org
Received: from mout.web.de (mout.web.de [217.72.192.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9581A1E25FA;
	Thu, 24 Oct 2024 15:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729783198; cv=none; b=H4jqICuX1Ko5VUqvNya8KJM/4WNOZwRRr/2ZKycDgl8OfiEQQk04XuKE/P6+pspXOb5unYos2ztj2CnLsG5Ve31hnRyDDjsQHMKmQEnDUnKlXhIEkrlPU5Rbq/r2z79JAP3ZC5SXU8JWPLE6cpHiINYt3lxSfumquBHaJ+m4YFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729783198; c=relaxed/simple;
	bh=WiDCNo3oleKefUodyK55wZpKSvxa7PhQmlGgswlx+kM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YqpEIGUXu9hlIDVrrfQeFq00ppQFpsQy0QDjRd5+/skkENhrjNaPhmw15Ej/bq4IgTrsiWpYxzk4wu0jinamGZjesJ7xIo48BID4eMD4kgDpfLE2NVdBEy1KWClJaWwogAaNle3w8qcRyolW3F1DvkVnzlJ0KeGHV7VDVHFvSFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=LS/+8UvI; arc=none smtp.client-ip=217.72.192.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1729783175; x=1730387975; i=markus.elfring@web.de;
	bh=WiDCNo3oleKefUodyK55wZpKSvxa7PhQmlGgswlx+kM=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=LS/+8UvIPaoH6PtKtLfOiq2D8es2WK6ZUxCOkX7GXDhsHCK7kSv2hWRG3x3gAbUe
	 wYEGI/Ar/IZoaeQxsXt9nRWEA2dr0HgEjzZTmFhzFUzCkSesBB2gYp3afM2AE/fRp
	 qSbe8GuMYY3I6r90czSikecqrWpBUAs2UTrybgMZ24kubU+tp0fBAflB+gsPrmEpn
	 ZvdHYtIY2Uxd1z2HWV97W+wY8eo4hm8q7a986r5Uzj7sccogE14mpVlpC1MAe5PWi
	 c+Oyl+Ys44Il7K68HOZs1n+2opafN+YbCU400cfBoadApNcCY0j2Is7b0nmCzF/8o
	 jJLAsD7O3CdVJ1Vx6g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.21] ([94.31.81.95]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MGgJM-1t7pO12phC-00212L; Thu, 24
 Oct 2024 17:19:35 +0200
Message-ID: <d8623fe7-3035-4c61-ab8c-502e3b33ecdc@web.de>
Date: Thu, 24 Oct 2024 17:19:34 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal/lib: Fix memory leak on error in
 thermal_genl_auto()
To: Daniel Lezcano <daniel.lezcano@linaro.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Zhang Rui <rui.zhang@intel.com>
References: <20241024105938.1095358-1-daniel.lezcano@linaro.org>
 <45265aca-7371-455f-819f-c4d68cbb089b@web.de>
 <9ba3fa17-57c3-41e9-9e19-33fa105a179e@linaro.org>
 <CAJZ5v0jWGdzakj8ob2otAO6auwGBvVsewujG-d9b1Z5nnO7Vkw@mail.gmail.com>
 <03a4edf1-9562-49fd-81fe-d96f46a41d28@linaro.org>
Content-Language: en-GB
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <03a4edf1-9562-49fd-81fe-d96f46a41d28@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:nVcAesFflG4NJvNEkSGRZu5VdFw4jT5APyQYamb8w9WYOxoRkLZ
 rrGMI9cBhI8dc+Q3uOTTuBoCCA5CEZA9obpefB/GYhJnF7o3OcyFeVhu8Qn4PKUyUzopCfV
 PjnWM3b9cPcQ7JjuqKiaWODkuAmnbIyEjZ9rN2M+jAHsnEuoup1bwT+JQjYvBQcFCm9EopR
 j+LvNdhq9EXCd1xtUNr4w==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:xthLxNB80YY=;1Gg5Fhfykm7WG/J4GH/e16YjDT0
 XmVOYwHIpGRezADMd4IN1pq3IFCtlPKJ7ZL+EzcrJcEvKELGbn7jBaH/xoIAfpCvHG3nA0seV
 qxpVCj56ZxWA9fouC+nq+n0MYzCHiBx1XSRzq8VWQzdLGkffxy2JoSaKIofrmrw2LqE13DNkU
 b+dtlzmWt2GAdUs3lrcSQz0p9pdHDRGtUI/eBhVYWNUmh5fv6Ok+AQ/U0mMVMRABLqKKePc7f
 fkF8+SvkIJfX6WAED83zCcbCfZ84aYVFzDZY8eJNMLtbYzHzrNuD2I7nfFb+R08OM3IfIRgiu
 RB2cB4v//C9XTQ8X6FSbNgRqmDU/AtV0h4qKnuyP09hJsp0tyQgMazoDjSbODKjBCz0h6b85Y
 NZls5Ufd9BnwMwi5n8us4BHv5lMCEYhwO9Qc8+wfQbyiNbj4TDcwmfUy4lvJyi6Fmyl1vE9Hd
 RLXjpZ1FpKk5wOgGD6ENwGNDpYakp2FhIFGqtEZ8Fjl59sKk8lbQqF5YjALmin9Wszc0pM5E0
 eOuurf3fqNHq5Va4TTHoxtqXHJQ0PYh6/tT0AzFEPNy88W09W/o7++lduoKsZafgvaIBO3aKH
 k3oer5G3mer3JRnHzqXDphrDDF5mxzCJS4sVbGdTsfXXlfNiwh3k1IWAIWGVinyMHrdMioNnZ
 InmuQtfsfc0fgCa6wnaXhuMYzJ7og2WjMk9U6PoUpTlIRNAimdk6pSKyxBbPJ7uJsyMW0QPMH
 LRuh9m6IQmXq+e5Qcdt34V1w/hUYNUiLmonakAUZj8mwRhKdMbDf5mtzWM0MVEEmhyuq6k909
 B0/kpCRFCf7/8iHWvXlESsYQ==

> For correctness, I'll send a V2 with the return fixed

Would you become similarly interested to increase the application of
scope-based resource management also for the affected software component?

Regards,
Markus

