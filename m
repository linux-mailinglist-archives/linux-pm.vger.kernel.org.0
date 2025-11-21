Return-Path: <linux-pm+bounces-38351-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07091C788F8
	for <lists+linux-pm@lfdr.de>; Fri, 21 Nov 2025 11:42:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 96FF2327CB
	for <lists+linux-pm@lfdr.de>; Fri, 21 Nov 2025 10:31:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE69734405D;
	Fri, 21 Nov 2025 10:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=benjamin.gaignard@collabora.com header.b="AjZP1bem"
X-Original-To: linux-pm@vger.kernel.org
Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C743343D84;
	Fri, 21 Nov 2025 10:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763721102; cv=pass; b=tP+g4YvbdT8w4H7YsHWqOKsS1Ty9rBDJ4F6gIRMm+dM3S27ZFIHXAoAlDpRYBJyIqlUxi6EEFtZ/dn09+jmyRSgYCFqo0VWixoJU8hO2n4P/s55FOfYZ3Q51v38NCatVfaOJzSdK6WQmcSGLP3BPFiQH0IzCRpC6nlI3f2qDJN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763721102; c=relaxed/simple;
	bh=UMxctActzyaJXwNlh6SB/Gw3BcnrbWi51U6cejUMVcs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kP2+TsozY+0Uy4Kpp7KLYhoU4irurKTxG1aOXI6djtiOBywHmUGBUyIajz4SCrDhk8gYqfiKTRhgzN9bOnUyXPiyj7KmTyhScAjrttiWt0F9gywbEGiFeeE5Eh1W75BhJbI01rOsl9pKYjLat4JwgMz6xDzM/QekeHvbZv3L7gE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=benjamin.gaignard@collabora.com header.b=AjZP1bem; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1763721068; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Iq8Ov80lrJX6+LHwHs0xm8fC1Wsply20gg7+T5a3661OGwPs089k35v8vpAM/IelV6duqgd2IPRRu6J3dHPqyczQmFqKtuEsTrXMbmAyQpUW6S3RaA9z+ihcQDM030QmOojyM4CdQblLTkCzdtWkPZsJw3FNn7S5DG3yemntxpk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1763721068; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=qQHzK2BSqPbNmZjYn7h/zJPYkRFHLnhXjNXGPoqjX0Q=; 
	b=M3fsSNFoPXMwrM2WhQ3FZLvZtauaN1oel7ogVIM6A8nQQNxvCWNRXKq5RfOEd1eDRPw8dcBcWT3OlZxh8WA01onOcZCSp90s0kQHLC4jZrQ7e5yJ5RM1/q4K6CKWfhek/q7ZRtmYVsk08HmpSBdJjYeCnA3oTVEWG7HKS5YZV3Q=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=benjamin.gaignard@collabora.com;
	dmarc=pass header.from=<benjamin.gaignard@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1763721068;
	s=zohomail; d=collabora.com; i=benjamin.gaignard@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=qQHzK2BSqPbNmZjYn7h/zJPYkRFHLnhXjNXGPoqjX0Q=;
	b=AjZP1bemhFSCaLhbZoMrxKfzCzXnJUS6f5nPQrWAWUpj04jI1x1qDOIGeuGTdB5N
	+MiATYxh59/kaPVLnXA4j0gwEYYEC9WV04G80AN9op+T9S02HsLWoT0PH5qk8X3P+33
	3gKSwYLmunqp1x4YCZ5DH8ezfbgN7fcfKmrOwxnQ=
Received: by mx.zohomail.com with SMTPS id 1763721066252962.4226785100166;
	Fri, 21 Nov 2025 02:31:06 -0800 (PST)
Message-ID: <10929ed9-7137-442c-9bea-5291b81bd630@collabora.com>
Date: Fri, 21 Nov 2025 11:31:01 +0100
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] media: verisilicon: Avoid G2 bus error while decoding
 H.264 and HEVC
To: ming.qian@oss.nxp.com, linux-media@vger.kernel.org
Cc: mchehab@kernel.org, hverkuil-cisco@xs4all.nl, nicolas@ndufresne.ca,
 p.zabel@pengutronix.de, sebastian.fricke@collabora.com, shawnguo@kernel.org,
 ulf.hansson@linaro.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
 festevam@gmail.com, linux-imx@nxp.com, l.stach@pengutronix.de,
 peng.fan@nxp.com, eagle.zhou@nxp.com, imx@lists.linux.dev,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20251121081911.1682-1-ming.qian@oss.nxp.com>
 <20251121081911.1682-2-ming.qian@oss.nxp.com>
Content-Language: en-US
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <20251121081911.1682-2-ming.qian@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Le 21/11/2025 à 09:19, ming.qian@oss.nxp.com a écrit :
> From: Ming Qian <ming.qian@oss.nxp.com>
>
> For the i.MX8MQ platform, there is a hardware limitation: the g1 VPU and
> g2 VPU cannot decode simultaneously; otherwise, it will cause below bus
> error and produce corrupted pictures, even led to system hang.
>
> [  110.527986] hantro-vpu 38310000.video-codec: frame decode timed out.
> [  110.583517] hantro-vpu 38310000.video-codec: bus error detected.
>
> Therefore, it is necessary to ensure that g1 and g2 operate alternately.
> Then this allows for successful multi-instance decoding of H.264 and HEVC.
> Fixes: cb5dd5a0fa518 ("media: hantro: Introduce G2/HEVC decoder")
> Signed-off-by: Ming Qian <ming.qian@oss.nxp.com>

Thanks for the patch.

Reviewed-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>

> ---
>   drivers/media/platform/verisilicon/hantro.h   |  1 +
>   .../media/platform/verisilicon/hantro_drv.c   | 26 +++++++++++++++++++
>   .../media/platform/verisilicon/imx8m_vpu_hw.c |  4 +++
>   3 files changed, 31 insertions(+)
>
> diff --git a/drivers/media/platform/verisilicon/hantro.h b/drivers/media/platform/verisilicon/hantro.h
> index e0fdc4535b2d..8baebf767d26 100644
> --- a/drivers/media/platform/verisilicon/hantro.h
> +++ b/drivers/media/platform/verisilicon/hantro.h
> @@ -101,6 +101,7 @@ struct hantro_variant {
>   	unsigned int double_buffer : 1;
>   	unsigned int legacy_regs : 1;
>   	unsigned int late_postproc : 1;
> +	atomic_t *shared_resource;
>   };
>   
>   /**
> diff --git a/drivers/media/platform/verisilicon/hantro_drv.c b/drivers/media/platform/verisilicon/hantro_drv.c
> index 60b95b5d8565..036ce43c9359 100644
> --- a/drivers/media/platform/verisilicon/hantro_drv.c
> +++ b/drivers/media/platform/verisilicon/hantro_drv.c
> @@ -19,6 +19,7 @@
>   #include <linux/slab.h>
>   #include <linux/videodev2.h>
>   #include <linux/workqueue.h>
> +#include <linux/iopoll.h>
>   #include <media/v4l2-event.h>
>   #include <media/v4l2-mem2mem.h>
>   #include <media/videobuf2-core.h>
> @@ -93,6 +94,9 @@ static void hantro_job_finish(struct hantro_dev *vpu,
>   
>   	clk_bulk_disable(vpu->variant->num_clocks, vpu->clocks);
>   
> +	if (vpu->variant->shared_resource)
> +		atomic_cmpxchg(vpu->variant->shared_resource, 0, 1);
> +
>   	hantro_job_finish_no_pm(vpu, ctx, result);
>   }
>   
> @@ -166,12 +170,34 @@ void hantro_end_prepare_run(struct hantro_ctx *ctx)
>   			      msecs_to_jiffies(2000));
>   }
>   
> +static int hantro_wait_shared_resource(struct hantro_dev *vpu)
> +{
> +	u32 data;
> +	int ret;
> +
> +	if (!vpu->variant->shared_resource)
> +		return 0;
> +
> +	ret = read_poll_timeout(atomic_cmpxchg, data, data, 10, 300 * NSEC_PER_MSEC, false,
> +				vpu->variant->shared_resource, 1, 0);
> +	if (ret) {
> +		dev_err(vpu->dev, "Failed to wait shared resource\n");
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>   static void device_run(void *priv)
>   {
>   	struct hantro_ctx *ctx = priv;
>   	struct vb2_v4l2_buffer *src, *dst;
>   	int ret;
>   
> +	ret = hantro_wait_shared_resource(ctx->dev);
> +	if (ret < 0)
> +		goto err_cancel_job;
> +
>   	src = hantro_get_src_buf(ctx);
>   	dst = hantro_get_dst_buf(ctx);
>   
> diff --git a/drivers/media/platform/verisilicon/imx8m_vpu_hw.c b/drivers/media/platform/verisilicon/imx8m_vpu_hw.c
> index 5be0e2e76882..1b3a0bfbf890 100644
> --- a/drivers/media/platform/verisilicon/imx8m_vpu_hw.c
> +++ b/drivers/media/platform/verisilicon/imx8m_vpu_hw.c
> @@ -324,6 +324,8 @@ static const char * const imx8mq_reg_names[] = { "g1", "g2", "ctrl" };
>   static const char * const imx8mq_g1_clk_names[] = { "g1" };
>   static const char * const imx8mq_g2_clk_names[] = { "g2" };
>   
> +static atomic_t imx8mq_shared_resource = ATOMIC_INIT(1);
> +
>   const struct hantro_variant imx8mq_vpu_variant = {
>   	.dec_fmts = imx8m_vpu_dec_fmts,
>   	.num_dec_fmts = ARRAY_SIZE(imx8m_vpu_dec_fmts),
> @@ -356,6 +358,7 @@ const struct hantro_variant imx8mq_vpu_g1_variant = {
>   	.num_irqs = ARRAY_SIZE(imx8mq_irqs),
>   	.clk_names = imx8mq_g1_clk_names,
>   	.num_clocks = ARRAY_SIZE(imx8mq_g1_clk_names),
> +	.shared_resource = &imx8mq_shared_resource,
>   };
>   
>   const struct hantro_variant imx8mq_vpu_g2_variant = {
> @@ -371,6 +374,7 @@ const struct hantro_variant imx8mq_vpu_g2_variant = {
>   	.num_irqs = ARRAY_SIZE(imx8mq_g2_irqs),
>   	.clk_names = imx8mq_g2_clk_names,
>   	.num_clocks = ARRAY_SIZE(imx8mq_g2_clk_names),
> +	.shared_resource = &imx8mq_shared_resource,
>   };
>   
>   const struct hantro_variant imx8mm_vpu_g1_variant = {

