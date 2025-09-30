Return-Path: <linux-pm+bounces-35575-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A7ABAB27C
	for <lists+linux-pm@lfdr.de>; Tue, 30 Sep 2025 05:30:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F1080192183E
	for <lists+linux-pm@lfdr.de>; Tue, 30 Sep 2025 03:30:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FF2E227BB9;
	Tue, 30 Sep 2025 03:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Vx6/AK4X"
X-Original-To: linux-pm@vger.kernel.org
Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 634C534BA3B;
	Tue, 30 Sep 2025 03:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759203030; cv=none; b=Oy1vdoM8pMn/1krMsGgZEIYWGrvAtIZGJGbW8/8QBGVs7YzZ6p/wlrzr2PwObCSqMLcqBLyrnndavRzxBSHljESnou182C7cj9/qExEJS6bx6tVB74zVAK5AwnUe39pMdgn48aOaLi3pYNDgh4BIgZPcUxLo/hMrZNI+/5bYVKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759203030; c=relaxed/simple;
	bh=K2CDWWJ0qHeT63F8FnvttaxWUTPHaaRdxaMKMFONkyM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=H0u4f6wRbLmxTWuZkYltoFApg1uekd1NG0boh2203vu7WjU/Dx6AiZf3CV0H7J+1D8+jRL4t74ryu0M6jaG/9xen3xEFoSL/OziM/bk1FnSkuI111eTn9d5+f4HvGj74apmu8Xt0jWAlarOmUdXNDhaYX6rW1uqCTQ4DsYHd9Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Vx6/AK4X; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1759203017; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=3Oem0W+qLeufbGvCLtT0cwgsYSGayEg+bGHSAtmWH8Q=;
	b=Vx6/AK4Xjg/YrSfU1hZ+YT8oHHDBwp1jirsYyYHc+vAPdC+JMl/VTP76SuSnF2Lr1czqeIf07Yu4xc6wLxVAGjEsVBzZCY/GfCDotvwA2NyOt+TvvhcBvS4zzLI3niHBdW4yXoemQQEcgNX1Lfxsai/Y5904TJI3XVjImNvZYEg=
Received: from 30.74.144.121(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0Wp9oxBz_1759203016 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 30 Sep 2025 11:30:17 +0800
Message-ID: <58441250-1f00-45ee-8583-9863efc938e0@linux.alibaba.com>
Date: Tue, 30 Sep 2025 11:30:16 +0800
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] power: reset: sc27xx: Add support for SC2730 and OF
 match table
To: =?UTF-8?Q?Otto_Pfl=C3=BCger?= <otto.pflueger@abscue.de>,
 Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Orson Zhai <orsonzhai@gmail.com>,
 Chunyan Zhang <zhang.lyra@gmail.com>, Lee Jones <lee@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20250926-sc2730-reboot-v1-0-62ebfd3d31bb@abscue.de>
 <20250926-sc2730-reboot-v1-4-62ebfd3d31bb@abscue.de>
From: Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <20250926-sc2730-reboot-v1-4-62ebfd3d31bb@abscue.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2025/9/27 00:23, Otto Pflüger wrote:
> Add register definitions for the SC2730 PMIC. Introduce a new struct
> sc27xx_poweroff_data for passing register information to the poweroff
> handler. Implement device tree matching to distinguish between SC2730
> and SC2731 and to probe the driver automatically.
> 
> Signed-off-by: Otto Pflüger <otto.pflueger@abscue.de>
> ---

If I remember correctly, the original driver supported SC2730 and SC2731 
chips. Are you sure the current changes are still needed? Have you 
tested them on the SC2730 chip?


config POWER_RESET_SC27XX
         tristate "Spreadtrum SC27xx PMIC power-off driver"
         depends on MFD_SC27XX_PMIC || COMPILE_TEST
         help
           This driver supports powering off a system through
           Spreadtrum SC27xx series PMICs. The SC27xx series
           PMICs includes the SC2720, SC2721, SC2723, SC2730
           and SC2731 chips.

