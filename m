Return-Path: <linux-pm+bounces-40046-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC72CE9CCA
	for <lists+linux-pm@lfdr.de>; Tue, 30 Dec 2025 14:39:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E6C9830198E2
	for <lists+linux-pm@lfdr.de>; Tue, 30 Dec 2025 13:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE9B423C4F4;
	Tue, 30 Dec 2025 13:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s+UzDTHu"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA2C8239099
	for <linux-pm@vger.kernel.org>; Tue, 30 Dec 2025 13:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767101992; cv=none; b=eTfXjNG08Rd0s1WN5ocsFDFjRWTH+RS/2BZnXPaf9/1WHHV0hesXvDLQL8EF9B1sz7e46lin0n0xLJf1JjzRyd48TURFsM4ZNIsbIzi9Dv8kmBUZ8riVHr0mNbIwNz46aEDJP+GhgJDtU8vvQApZDZ4TfrrPqzjO0crDJaXYit4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767101992; c=relaxed/simple;
	bh=OlkCqn8fXbP0BKS1z87/ZV5T/EiSvUw1/xi0wc+ejKM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HsySbXdXD4k5hIq4YWKa07GvOsBhSOGLcjHo3yFUiwWgvPI5SVI7e3h+J6MbvK5lNwXyG/PbbfjBHNO6DPhoVmCS8TiLibImsyOc/jYmLgF800kU27lokw2B2PzLQlEBSnW6+tbmjTVlItg24mBjQShWnvZwITFq0sYWbaQqSHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=s+UzDTHu; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-59445ee9738so7891494e87.3
        for <linux-pm@vger.kernel.org>; Tue, 30 Dec 2025 05:39:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1767101989; x=1767706789; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Bg1+ls4Dm0mVYOjkWjZgFsYapx+e4w8tJTjnMs5lrKs=;
        b=s+UzDTHuiGeSzvMLtmoAi5M5IJShFvnkkIDQ0GL1WL3pJ19ovhKE4nXHDxiOoUzcFg
         nIuardYjfu/ByuSCB+1kAxw1+mdBPUiadyZaoe3ucTO3cw5rBdm0gvFcL+5VB+pfioAY
         9CVatTIDXR+8ap1X+u8RPguYMepfTX6gZk6CTeinZAyy0VDrLULXfHP4npHYyikTGHV5
         In1U+MeUdq1nQHxhCfiaww3IFqmw4EwIK7WCM8RVxJNkNf1zosp+3Ko/F3bxID5b5ztQ
         gcCUFq2/u2hrs5BjJfge12+7oAbMb6Lybf0zkB1WLvobtm7lXrWjkrvlsOOrwlcXqCwz
         73kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767101989; x=1767706789;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bg1+ls4Dm0mVYOjkWjZgFsYapx+e4w8tJTjnMs5lrKs=;
        b=I3oc6RM44BUmCOgseutpYh+UAaV0vBnLkjIBntxe70baXqipMBJqc7ui8mbS9vJ0jk
         MJgef5z/bRQuNTV8kb4QFoNiNoyiEF4UP96LdAqinWEnvG2e8OtB01vn/a6QO8javupg
         v8AEMdR+etjqYIuBfnjgiUjJc01+9kG6jEo/akerC0CI5cUz8Br68jGd/y24F4+ycFwc
         7cXfUCwgPjQJDTgbkuZodppdZKZqnj05zS8f+0cEzMweWwI0P2AvW43QTw1t0N0cV2s1
         KxbHLEO90I1jfi7HU4QML9C/Gm46PZqgPe9/YbuPeCqEEyG7tus5MTTTnNDmckOm+1Gm
         GFdA==
X-Forwarded-Encrypted: i=1; AJvYcCV/GQ+q8XOUCeRTSLiG37GhYbt4s9XGzVwyN8c+j8sU7ewp5d2HKQnpX+1i+UBc3zezl2C5DszkvA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0CXhqThL3HR0+5HYFWzCTLoce66w4xE1Si2stip/s6f3KQsj1
	8vdo1BLKP3TSiwLfDmuIKBkC58yEDzXx961rWppU3/MFedcpd0z5mmN8m9jegyb6h4rgQyuK3Kj
	NzoR7Mwvpgw8ACfMnHNVN5ga5kZej6n9zo85xje7H+Q==
X-Gm-Gg: AY/fxX6Xi2C5zHQi39wurC6kOcnGDQlSUPDvE7sGvJO+t4l0XOgKXo8fO3sQSf/+pXs
	FRXPRYONfatVRQSpCQmVBwip/e+6rv3WS7AkSDzvds+1lvQGoMIi3iOkdFDUTCoZ8ciSeiYEvJI
	2Tykb+7FOq6g+uJTf5XBl/H2bZCUJQBSHL3Y2FCb7012zmwoJso/aPe9GL8Y41K5P+9jAWzyYAN
	JojddZr5j3gicaEkPFEICEOXLWxcn71XGmKUMAB5d626HwSl1VGHVCL4ST3+otFk8fRTVG3
X-Google-Smtp-Source: AGHT+IFc2q13TthZOLNMt7KlXgzpHYzWQ4Oc1qku0cPr+yLi0Y1e7lT6nY190irxS/Myr4DyEyhRfiOI15TA9SqTEa4=
X-Received: by 2002:a05:6512:b20:b0:594:2870:9774 with SMTP id
 2adb3069b0e04-59a17d670f6mr11077610e87.38.1767101988845; Tue, 30 Dec 2025
 05:39:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251205015428.643-1-ming.qian@oss.nxp.com> <20251205015428.643-2-ming.qian@oss.nxp.com>
In-Reply-To: <20251205015428.643-2-ming.qian@oss.nxp.com>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Tue, 30 Dec 2025 14:39:12 +0100
X-Gm-Features: AQt7F2p9Tp60FXm9JL954U-IrjyLLANKEoHVrFFumJZKPA0geVKKGoJbY19yu5A
Message-ID: <CAPDyKFpt-GL-RFcJ5mTWFqaRfy1dQJ7LL8OBCoQK0+zPDFEzsg@mail.gmail.com>
Subject: Re: [PATCH v4 1/3] media: v4l2-mem2mem: Add a kref to the
 v4l2_m2m_dev structure
To: ming.qian@oss.nxp.com
Cc: linux-media@vger.kernel.org, mchehab@kernel.org, hverkuil-cisco@xs4all.nl, 
	nicolas@ndufresne.ca, benjamin.gaignard@collabora.com, p.zabel@pengutronix.de, 
	sebastian.fricke@collabora.com, shawnguo@kernel.org, s.hauer@pengutronix.de, 
	kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, 
	l.stach@pengutronix.de, Frank.li@nxp.com, peng.fan@nxp.com, 
	eagle.zhou@nxp.com, imx@lists.linux.dev, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 5 Dec 2025 at 02:55, <ming.qian@oss.nxp.com> wrote:
>
> From: Nicolas Dufresne <nicolas.dufresne@collabora.com>
>
> Adding a reference count to the v4l2_m2m_dev structure allow safely
> sharing it across multiple hardware nodes. This can be used to prevent
> running jobs concurrently on m2m cores that have some internal resource
> sharing.
>
> Signed-off-by: Nicolas Dufresne <nicolas.dufresne@collabora.com>
> Signed-off-by: Ming Qian <ming.qian@oss.nxp.com>

I certainly don't have the complete picture for how this needs to work.

However, I was thinking that rather than using a kref and having to
share two specific functions to update it (v4l2_m2m_get|put), couldn't
we just use a device-link instead?

Kind regards
Uffe

> ---
> v4
> - Add my Signed-off-by
>
>  drivers/media/v4l2-core/v4l2-mem2mem.c | 23 +++++++++++++++++++++++
>  include/media/v4l2-mem2mem.h           | 21 +++++++++++++++++++++
>  2 files changed, 44 insertions(+)
>
> diff --git a/drivers/media/v4l2-core/v4l2-mem2mem.c b/drivers/media/v4l2-core/v4l2-mem2mem.c
> index fec93c1a9231..ae0de54d4c3e 100644
> --- a/drivers/media/v4l2-core/v4l2-mem2mem.c
> +++ b/drivers/media/v4l2-core/v4l2-mem2mem.c
> @@ -90,6 +90,7 @@ static const char * const m2m_entity_name[] = {
>   * @job_work:          worker to run queued jobs.
>   * @job_queue_flags:   flags of the queue status, %QUEUE_PAUSED.
>   * @m2m_ops:           driver callbacks
> + * @kref:              device reference count
>   */
>  struct v4l2_m2m_dev {
>         struct v4l2_m2m_ctx     *curr_ctx;
> @@ -109,6 +110,8 @@ struct v4l2_m2m_dev {
>         unsigned long           job_queue_flags;
>
>         const struct v4l2_m2m_ops *m2m_ops;
> +
> +       struct kref kref;
>  };
>
>  static struct v4l2_m2m_queue_ctx *get_queue_ctx(struct v4l2_m2m_ctx *m2m_ctx,
> @@ -1200,6 +1203,7 @@ struct v4l2_m2m_dev *v4l2_m2m_init(const struct v4l2_m2m_ops *m2m_ops)
>         INIT_LIST_HEAD(&m2m_dev->job_queue);
>         spin_lock_init(&m2m_dev->job_spinlock);
>         INIT_WORK(&m2m_dev->job_work, v4l2_m2m_device_run_work);
> +       kref_init(&m2m_dev->kref);
>
>         return m2m_dev;
>  }
> @@ -1211,6 +1215,25 @@ void v4l2_m2m_release(struct v4l2_m2m_dev *m2m_dev)
>  }
>  EXPORT_SYMBOL_GPL(v4l2_m2m_release);
>
> +void v4l2_m2m_get(struct v4l2_m2m_dev *m2m_dev)
> +{
> +       kref_get(&m2m_dev->kref);
> +}
> +EXPORT_SYMBOL_GPL(v4l2_m2m_get);
> +
> +static void v4l2_m2m_release_from_kref(struct kref *kref)
> +{
> +       struct v4l2_m2m_dev *m2m_dev = container_of(kref, struct v4l2_m2m_dev, kref);
> +
> +       v4l2_m2m_release(m2m_dev);
> +}
> +
> +void v4l2_m2m_put(struct v4l2_m2m_dev *m2m_dev)
> +{
> +       kref_put(&m2m_dev->kref, v4l2_m2m_release_from_kref);
> +}
> +EXPORT_SYMBOL_GPL(v4l2_m2m_put);
> +
>  struct v4l2_m2m_ctx *v4l2_m2m_ctx_init(struct v4l2_m2m_dev *m2m_dev,
>                 void *drv_priv,
>                 int (*queue_init)(void *priv, struct vb2_queue *src_vq, struct vb2_queue *dst_vq))
> diff --git a/include/media/v4l2-mem2mem.h b/include/media/v4l2-mem2mem.h
> index bf6a09a04dcf..ca295c660c7f 100644
> --- a/include/media/v4l2-mem2mem.h
> +++ b/include/media/v4l2-mem2mem.h
> @@ -547,6 +547,27 @@ v4l2_m2m_register_media_controller(struct v4l2_m2m_dev *m2m_dev,
>   */
>  void v4l2_m2m_release(struct v4l2_m2m_dev *m2m_dev);
>
> +/**
> + * v4l2_m2m_get() - take a reference to the m2m_dev structure
> + *
> + * @m2m_dev: opaque pointer to the internal data to handle M2M context
> + *
> + * This is used to share the M2M device across multiple devices. This
> + * can be used to avoid scheduling two hardware nodes concurrently.
> + */
> +void v4l2_m2m_get(struct v4l2_m2m_dev *m2m_dev);
> +
> +/**
> + * v4l2_m2m_put() - remove a reference to the m2m_dev structure
> + *
> + * @m2m_dev: opaque pointer to the internal data to handle M2M context
> + *
> + * Once the M2M device have no more references, v4l2_m2m_realse() will be
> + * called automatically. Users of this method should never call
> + * v4l2_m2m_release() directly. See v4l2_m2m_get() for more details.
> + */
> +void v4l2_m2m_put(struct v4l2_m2m_dev *m2m_dev);
> +
>  /**
>   * v4l2_m2m_ctx_init() - allocate and initialize a m2m context
>   *
> --
> 2.52.0
>

