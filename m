Return-Path: <linux-pm+bounces-5785-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E45E894A1D
	for <lists+linux-pm@lfdr.de>; Tue,  2 Apr 2024 05:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4053B1C235DB
	for <lists+linux-pm@lfdr.de>; Tue,  2 Apr 2024 03:39:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400D6175BD;
	Tue,  2 Apr 2024 03:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KAJr+KJl";
	dkim=pass (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b="OkI/ZIuD"
X-Original-To: linux-pm@vger.kernel.org
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8CAD1759F;
	Tue,  2 Apr 2024 03:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712029169; cv=none; b=KzBi5eCw4bHtVACLCpBSJfglOYzVzl4oirDsTLwTLx+3NtK3YdNTUHA8qEwZVnyZxboHsGE/+4ohEi03IsT4xVWJ806ARAR4DyPds+UKtFPvViyOnmlJYidTSf/Zd2zzI96tLkF+ZSvJ1awoEaG+On4yO1IvGE4TwOSk52I4GXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712029169; c=relaxed/simple;
	bh=wdEV36OYqhfJhCJJLd5ThlK8EcnpX/S7YsoXCp2ZC1o=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=m3UKApIpD0yDs5oI8LUnahWZdMPb/zA+3boa94hBGYwZk3uv7bsAzJRpg2zWwPIDMdOWkWpdejzGtB/GSE0g7/97kAc9NmyR9mig/+VPAkjDlIltQNG6uDPY9RwUPpAqWx0BRc+y/8OSuuqfIgajXvCYizXf7DJochNI8MTuIWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net; spf=pass smtp.mailfrom=fluxnic.net; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=KAJr+KJl; dkim=pass (1024-bit key) header.d=fluxnic.net header.i=@fluxnic.net header.b=OkI/ZIuD; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=fluxnic.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fluxnic.net
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 5730021C64;
	Mon,  1 Apr 2024 23:39:27 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
	:to:cc:subject:in-reply-to:message-id:references:mime-version
	:content-type; s=sasl; bh=wdEV36OYqhfJhCJJLd5ThlK8EcnpX/S7YsoXCp
	2ZC1o=; b=KAJr+KJl8jsjRCtvLAt4upb2p+BNypV2Pmp5Cxtk1j0xUvFZ8XdboC
	xBK10keQIJGfwqpf8Ls/pZAHkUluyP3wU/0ND1EV4ielspfiKZ6nVs3AOBbgwS+Q
	FrkLAzXjWB1Jyub1Wev6yuLC7EdF2U6XqriKQVYj/NaH8nJXBy5os=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 50E6721C63;
	Mon,  1 Apr 2024 23:39:27 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=fluxnic.net;
 h=date:from:to:cc:subject:in-reply-to:message-id:references:mime-version:content-type; s=2016-12.pbsmtp; bh=wdEV36OYqhfJhCJJLd5ThlK8EcnpX/S7YsoXCp2ZC1o=; b=OkI/ZIuDRHJtVLRcvG6HVa+YB2HXoiUFZu7ovOxilA+bFOBTF2qWemKhOTj7BEISmPTeLfdt51Me9UabeMeX8G8/eCJdZpki68W+AuJZEvfibKacGdgXatR+eL8o3rjoAN4bFMPOsO9yQOU/l8ZZALKJtDAficaAvLNKG2ZFNAQ=
Received: from yoda.fluxnic.net (unknown [24.201.101.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 3B43E21C61;
	Mon,  1 Apr 2024 23:39:23 -0400 (EDT)
	(envelope-from nico@fluxnic.net)
Received: from xanadu (unknown [IPv6:fd17:d3d3:663b:0:9696:df8a:e3:af35])
	by yoda.fluxnic.net (Postfix) with ESMTPSA id 3409FC1CF05;
	Mon,  1 Apr 2024 23:31:49 -0400 (EDT)
Date: Mon, 1 Apr 2024 23:31:49 -0400 (EDT)
From: Nicolas Pitre <nico@fluxnic.net>
To: Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org, 
    linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org
cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v3 00/15] Mediatek thermal sensor driver support for
 MT8186 and MT8188
In-Reply-To: <20240402032729.2736685-1-nico@fluxnic.net>
Message-ID: <84sp6nnp-2ppp-s388-7290-49p996n6n969@syhkavp.arg>
References: <20240402032729.2736685-1-nico@fluxnic.net>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Pobox-Relay-ID:
 98B70D10-F0A2-11EE-A267-A19503B9AAD1-78420484!pb-smtp21.pobox.com

On Mon, 1 Apr 2024, Nicolas Pitre wrote:

> This is a bunch of patches to support the MT8186 and MT8188 thermal
> sensor configurations.

They were tagged "v2" despite being "v3". Please follow the thread.


Nicolas

