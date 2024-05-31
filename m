Return-Path: <linux-pm+bounces-8486-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7AA28D6732
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2024 18:48:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 651B31F2680F
	for <lists+linux-pm@lfdr.de>; Fri, 31 May 2024 16:48:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A2017622D;
	Fri, 31 May 2024 16:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ZaGdCm2c"
X-Original-To: linux-pm@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC491C687;
	Fri, 31 May 2024 16:46:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717174003; cv=none; b=CBNgYPYFuenSkJJD84lDv/5z/TUpASRxDPD6WuzJJUabWakYic8S8kS+PPCu4FsGSVgNEAofgxphU9Y3FbLBBaUXUGvH50VFf3gXsEeIy4aKrwaCGFnLrI0fQ3TXKAWVX4ofp4Tq+gsBvWXG4vSp6rs0Fynev/siMQYCaVk3Gy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717174003; c=relaxed/simple;
	bh=vl+OzXBkcyl/K8QlbTfHieJK45Wo4xQ9zNN/E5LU1KA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n9OOwWKO/uNzqI9lzIZmbTJpt1CQPq6hEnQ6Rlv/EDQr7XE46zYY9uusw5H+jxymvrVf/JetLN2BfqDtZeIMQxtBKw8f5Ks38b1SVQCZhEeVUxQbn8U4xP0t1hj1sZiGeyMF48BBAphtd5TnHYmS5mikkyML/mSa6f07AZ5/eyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ZaGdCm2c; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 46391E0003;
	Fri, 31 May 2024 16:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1717173992;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p9anr0RVYsC2MJ/PCDVLLwSTD2hCQkDYEjVNxH2J/k8=;
	b=ZaGdCm2c/xsgoUVIY12YgPlfvKGvBTXD1C6Wk5rLI0PAfMOzUoCBOXjz8lmFGvZ5VNlEUS
	OiESjPyqUi8V103qu3cCImyrfEXe3dUf6+F5kIhc31DSEkYpsGVu9Pc4FyTDBWzyb5I0gV
	tELDL226L2x3Gnoro2EYqsfD+mnwkKEERkUWZx+m8j/1v36vCkb9cIJ624znsCf7Do1r5R
	dYQEa5iwl0qdtcQgYgj5chSMMY0seb6kpwpFSf+21DykX6F0HPJnqTs5Oq0x6NUGSzKwft
	i9cfWlI8IVy1HKXIIuO8yvG14zfqYEVpAvfJnPyakxY/gb04XIPVjsiKpzMcQw==
Message-ID: <8c7af9d1-c980-4a32-b5c1-f109c87af7e2@bootlin.com>
Date: Fri, 31 May 2024 18:46:30 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] thermal: k3_j72xx_bandgap: implement suspend/resume
 support
To: rafael@kernel.org, daniel.lezcano@linaro.org
Cc: rui.zhang@intel.com, lukasz.luba@arm.com, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org, gregory.clement@bootlin.com,
 thomas.petazzoni@bootlin.com, theo.lebrun@bootlin.com, u-kumar1@ti.com,
 j-keerthy@ti.com
References: <20240425153238.498750-1-thomas.richard@bootlin.com>
Content-Language: en-US
From: Thomas Richard <thomas.richard@bootlin.com>
In-Reply-To: <20240425153238.498750-1-thomas.richard@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: thomas.richard@bootlin.com

On 4/25/24 17:32, Thomas Richard wrote:
> From: Théo Lebrun <theo.lebrun@bootlin.com>
> 
> This add suspend-to-ram support.

Hello,

Gentle ping.
No merge conflict with 6.10-rc1.

Best Regards,

Thomas
-- 
Thomas Richard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


