Return-Path: <linux-pm+bounces-14023-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 849DB9754CB
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 15:57:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28FD1B2BA50
	for <lists+linux-pm@lfdr.de>; Wed, 11 Sep 2024 13:57:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F00211AE047;
	Wed, 11 Sep 2024 13:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fbzgJ/gL"
X-Original-To: linux-pm@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1740B186607
	for <linux-pm@vger.kernel.org>; Wed, 11 Sep 2024 13:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726062776; cv=none; b=eQbHpXZjROtBqai4so8CiUxUGB9T4GAXSl0frMChZEuHAyKFkpFoFBhVAFCumkv5UqV7FMPM0xY1lL+4CYJQk7A74rB9G33tNcmGwt72MOhVmi02Cn5zFrj+X3o0lBUFD6PE6SxG/qTidoYYJ5BqjHjM0baSA5/vt0eV5pqsOV8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726062776; c=relaxed/simple;
	bh=90syEosigoQtFwy3mDxHWPdRai93pP02ONNHq91DD3c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fb5rnfC1LsqzDDlgNggAsVR7PyG7r9Jkf1LEuzxO6W4mhB1DTF8v0s3uICdXoO4AUKjv3PU/RItpHYg6xFOzJQRQf2DQa9jwB2/+T8G/C0Vh5BQlH9rfwJ3Qz0HNbGkKubnoPpVjYfGK9AVT6dovdYhkWSzykyOogVJ3lD/8UGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fbzgJ/gL; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726062773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kdiGlxkXyOR+dWRdi9LeJcx6OQ3pwwF6HACz6X373cI=;
	b=fbzgJ/gLTrCR0A9hDfx9IcrDrBfsEgwFdM+dfuXYoJoAkZJlick9Rz0E9SgyxCdY4XxKB1
	+OpuHvmKaTMYwQS4jt5NJ98P0esUuNtLKhYqVV7cNjvvLvSqbZFxpnglSOew7UJ39KallX
	dR+nApry8s1WQzh2WryNC13UH9XnOWI=
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com
 [209.85.222.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-620-1qal8wL8O56V63JW-RszYQ-1; Wed, 11 Sep 2024 09:52:52 -0400
X-MC-Unique: 1qal8wL8O56V63JW-RszYQ-1
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-8486337c179so237157241.0
        for <linux-pm@vger.kernel.org>; Wed, 11 Sep 2024 06:52:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726062771; x=1726667571;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kdiGlxkXyOR+dWRdi9LeJcx6OQ3pwwF6HACz6X373cI=;
        b=Zr7NaIMSTgsaqYVl/X2+IUfJIVa1VDu0t6QdQqWU69JK1lIDjvE4XxFQatkZyGa8Ey
         2TQn5+8m5JX21fzuLWz+EhC+ftIdj4P3/4BTg22lug+bLTtips+i8x9Qg6o22aylNkJI
         r8j6UAZPV3WGEvNuXk1ioqsEecckMLlgNrcsIqkONRxYyrmVaDAti3RNajJf+pSNXJ9n
         X6Inckd80hAjxytfQxtL1uJYX1WiK/XSxKcyUbjQkSg5wdfDilseEgE7wvNBn6QfKAIc
         3d2F+pREANEzOCjik+6GJgga58D1rcNXwwibwUOeJ8gfO0Z7GYNWwA3tjwl6/rtyzIf/
         Q3HA==
X-Forwarded-Encrypted: i=1; AJvYcCWOswSH4Ye0nLpZADXqDkSAYgn+vzynKOKL4noinT1ZGzq4wjm1im13aWPaqw1KUmBE5u2MUdVmhQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzrLhoNjMm5nYf+5Raay0St2hLx5jsC1pG7IdlXBpIDTyqpQPcb
	w4SkKcsTjV+1NjzSGEPAnTL65xQEpKmvhBhh5ZF6WGqW5+276voDiuGf0CsA4+a3FOJsrNkUyH5
	5DxKID2cZ9wg4cuxNMgHji7kxuVV/qsIpL+n64PBoaJivih9jBO9ifLbr
X-Received: by 2002:a05:6102:cd0:b0:493:b9a0:8ee8 with SMTP id ada2fe7eead31-49c241fcbb7mr2253885137.22.1726062771470;
        Wed, 11 Sep 2024 06:52:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGABJYVskb5+BBP2xYINiPi2dUXsWiKxhCZm1mIGirxLhvlWwWlv0zCkL5Ylsa8eqWqhE2NTA==
X-Received: by 2002:a05:6102:cd0:b0:493:b9a0:8ee8 with SMTP id ada2fe7eead31-49c241fcbb7mr2253869137.22.1726062771033;
        Wed, 11 Sep 2024 06:52:51 -0700 (PDT)
Received: from x1gen2nano ([2600:1700:1ff0:d0e0::33])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6c534786b52sm41693896d6.142.2024.09.11.06.52.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 06:52:50 -0700 (PDT)
Date: Wed, 11 Sep 2024 08:52:48 -0500
From: Andrew Halaney <ahalaney@redhat.com>
To: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
Cc: Georgi Djakov <djakov@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Odelu Kukatla <quic_okukatla@quicinc.com>, 
	Jeff Johnson <quic_jjohnson@quicinc.com>, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Mike Tipton <quic_mdtipton@quicinc.com>, 
	Bjorn Andersson <andersson@kernel.org>
Subject: Re: [PATCH V2] interconnect: qcom: icc-rpmh: probe defer incase of
 missing QoS clock dependency
Message-ID: <qyuhuhgeajozxjhaddeapfv7pdhutagqevr2fiu4fu5wh6ybjn@pxxgvjrad477>
References: <20240911094516.16901-1-quic_rlaggysh@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240911094516.16901-1-quic_rlaggysh@quicinc.com>

On Wed, Sep 11, 2024 at 09:45:16AM GMT, Raviteja Laggyshetty wrote:
> Return -EPROBE_DEFER from interconnect provider incase probe defer is
> received from devm_clk_bulk_get_all(). This would help in reattempting
> the inteconnect driver probe, once the required QoS clocks are
> available.
> 

Might be a bit overzealous, but to me this feels like a fix so something
like:

    Fixes: 0a7be6b35da8 ("interconnect: qcom: icc-rpmh: Add QoS configuration support")

might be appropriate? What are your thoughts?


> Suggested-by: Bjorn Andersson <andersson@kernel.org>
> Signed-off-by: Raviteja Laggyshetty <quic_rlaggysh@quicinc.com>
> ---
> Changes in v2:
>  - Removed the qos_clk_required rename change and posted it as separate
>    patch.
>  - As suggested, dev_err_probe is used for reporting the probe defer
>    error message.
> ---
>  drivers/interconnect/qcom/icc-rpmh.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/interconnect/qcom/icc-rpmh.c b/drivers/interconnect/qcom/icc-rpmh.c
> index f49a8e0cb03c..adacd6f7d6a8 100644
> --- a/drivers/interconnect/qcom/icc-rpmh.c
> +++ b/drivers/interconnect/qcom/icc-rpmh.c
> @@ -311,6 +311,9 @@ int qcom_icc_rpmh_probe(struct platform_device *pdev)
>  		}
>  
>  		qp->num_clks = devm_clk_bulk_get_all(qp->dev, &qp->clks);
> +		if (qp->num_clks == -EPROBE_DEFER)
> +			return dev_err_probe(dev, qp->num_clks, "Failed to get QoS clocks\n");
> +
>  		if (qp->num_clks < 0 || (!qp->num_clks && desc->qos_clks_required)) {
>  			dev_info(dev, "Skipping QoS, failed to get clk: %d\n", qp->num_clks);
>  			goto skip_qos_config;
> -- 
> 2.39.2
> 
> 


