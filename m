Return-Path: <linux-pm+bounces-7517-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD0F8BC89F
	for <lists+linux-pm@lfdr.de>; Mon,  6 May 2024 09:52:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A7051F22456
	for <lists+linux-pm@lfdr.de>; Mon,  6 May 2024 07:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E76D140381;
	Mon,  6 May 2024 07:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="kEPNrJhb"
X-Original-To: linux-pm@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3794381DF;
	Mon,  6 May 2024 07:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714981959; cv=none; b=Uuyl7rq4ls9d0KvIxPYqvcuVoMI8oWDQUNVKKnaU/guoqmBgW5X4WaSlkiYLdzh/9q1szloQCb5+9xOSjfD0QjQIWC2GzhFFsNXwQXSNIgA7eJ/PifI3jgTXrIwsycS2XIhITR1op00i1JuYtgsKGhAoP05+n0T+AJc9givby3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714981959; c=relaxed/simple;
	bh=vaxxs/M5hBvQ8y2s2UpxySg17jKI9dQQxEa2rqW65Fc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ju6P2Pk0uD73uftJVLdYnmeNTOQfKIil2P4lD5XPvqY5+zRS/0dmKHjMOcElkzyo7+M3DEyCStD1xtgy+KzrsEbajjXs9IPSObGNaAOQY0tlz9TiTIx/XqYcFY6LpVsIgaNPVizmGhi/cQl6TgiO+PjF38pqtiz3qRWn8eOm3dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=kEPNrJhb; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1714981956;
	bh=vaxxs/M5hBvQ8y2s2UpxySg17jKI9dQQxEa2rqW65Fc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=kEPNrJhbGm4ZIYASKEr2O8XwgghSuwg6G3uq56sBacgttu3k/hqa8p7WbxQ+QbzUl
	 fW1oCyaHnwzen5uv16SiKHfHmoEOXiRTi1xwkuzq3xYF6QVIrS/AtEQMEQFL9aP9pQ
	 aSmIuOvZufCwxpmgad4159ZXz0SYIi9qqTA1Aq9Wf7+gUT6C9Ksx7kIC9nE9wqTLZU
	 uBEsd0KggHVQ99mtQXIZEvIsDSjGEA4pkaO1eJXUxQXRWOewHi2rmsM5mjK8WYixBZ
	 xFbI3XQb+nKvd/WMWqMlEv3WLEKjmqBrRDvSZPNQWzjLEhvLvXt89oSSMcb6fUnhTo
	 ixvfxC2m4pt2A==
Received: from [100.113.186.2] (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: kholk11)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 788E337820D8;
	Mon,  6 May 2024 07:52:35 +0000 (UTC)
Message-ID: <aeba862a-0694-40de-8b87-a5f22ca88127@collabora.com>
Date: Mon, 6 May 2024 09:52:34 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] thermal/drivers/mediatek/lvts_thermal: Remove unused
 members from struct lvts_ctrl_data
To: Julien Panis <jpanis@baylibre.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 Nicolas Pitre <npitre@baylibre.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20240503-mtk-thermal-lvts-ctrl-idx-fix-v1-0-f605c50ca117@baylibre.com>
 <20240503-mtk-thermal-lvts-ctrl-idx-fix-v1-1-f605c50ca117@baylibre.com>
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Content-Language: en-US
In-Reply-To: <20240503-mtk-thermal-lvts-ctrl-idx-fix-v1-1-f605c50ca117@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Il 03/05/24 17:35, Julien Panis ha scritto:
> In struct lvts_ctrl_data, num_lvts_sensor and cal_offset[] are not used.
> 
> Signed-off-by: Julien Panis <jpanis@baylibre.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>



