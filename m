Return-Path: <linux-pm+bounces-33412-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B6CACB3BD53
	for <lists+linux-pm@lfdr.de>; Fri, 29 Aug 2025 16:18:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C6197A2388
	for <lists+linux-pm@lfdr.de>; Fri, 29 Aug 2025 14:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4567B31CA4D;
	Fri, 29 Aug 2025 14:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lVCI2wfO"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E47315790
	for <linux-pm@vger.kernel.org>; Fri, 29 Aug 2025 14:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756477078; cv=none; b=txY4lGF54B0fDZELyLEOdgMyJkaAEKQn3UXBwtj+xXsqvXFOq1JmuVp7FOYaoky7zBCNS+K7is5XbNBsQDi2gK/rTMYcHk7YuXvheIA00rWLdl2RY4jui/x6xxS+vqwRL4CZWmcJuHFncSFeQzmfqPEucwhES3hu8ala51UbtdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756477078; c=relaxed/simple;
	bh=jL7e0H9l7oWIUOWsTHCRgC8GOaaqt4s2mWR0NDrqIeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JOeKihsByrKIbTj8Ol/8uMaInpux+sQQF+unxR9FO92Bo8M3WGrbiurtERMlcVXpTYMCpuuCOL6/kOLY5mdijj8K2HWMUoexRPI3Z9RkVvuHkVnvP63JenM1uxZInQg0hy19zf6wIBU5iRBqoQkcjXXAAbxBtD+MZn43lBr5g7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lVCI2wfO; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-3d0dd9c9229so534406f8f.1
        for <linux-pm@vger.kernel.org>; Fri, 29 Aug 2025 07:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1756477075; x=1757081875; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0UKM7Hh31pGB257PcQYyxWg4WwmJZnesfP8m107J2rg=;
        b=lVCI2wfOQwoPedWM3+RtRzFT9pNwfXVDaS2Fvg/l/DeyoS6GPtud56wQ4CltgeNldn
         vjvCKKUJcrY+2wQC8Miw2Gzus4df7YiAKxqjj5H9nUBkGgVtMgwNqXP5cvXwmRB/5Z6c
         KQ2DGyDBO9Ce1aAYa06uVcsCuKjkvPqxhh8g8Sysz1E68/P/7gW1VZORgzNab83iq8mM
         YwfmItfhuSfK5CluC57TgI16DNdujK5h0MGxMPS5zBqVkNOASzph41x7FIbjMsnbWXBM
         +tZfpk7XjHMP6JAws5avQ0ONGK0/d2YgbILlJmfAx7nv9p8Uf8iwnRTrCv6sevsDn3TH
         vbyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756477075; x=1757081875;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0UKM7Hh31pGB257PcQYyxWg4WwmJZnesfP8m107J2rg=;
        b=AtQTdO7JX9xQldEgkFjvoggh6cN23fIXBrmodwQFbBEniFqy68UXu6KSgqocMQCC5Z
         a8e2jyJIWFNj1Xqe4Mwxzpue0pQR9vVd7agNDBEA6EYjyk6xwFQUHejnGCdUK0yb8Xcn
         R+qhBow/RYnE0PahXhHD3T+Gt83Kl0O4QcUS9o7OZZ2qcBFIZHxL3Zh8XNMDn0wXOkzB
         sET86Hrtp+M7lQP90ehTl85cZ5+jojf8MwLMz0VFlWU7B7qz2Y9GCZzYD9E1XKXpIPya
         GdLAgfrz9gcimCJ6MwG0M1FLBleBh9zYrU01Z3QopuHXnggruWyakECtsU2ipEok05U6
         B37A==
X-Forwarded-Encrypted: i=1; AJvYcCUTBJrPDvVCXFyCrQPmjkIxOZr4GzbDnskLI/DOGUHwzxUhc0l9HQanUEbGd3dYwHqKKg/aYtHm9A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0yJC0kbT1kDSh3fR6FZnkyz3p7SfE0Kj4NUINMcnlZ99AgrT/
	uq677Y61uqRE+Gf9+G2TvGFmGJXmptqzawkNLRXcQs6xw72aPHsC16y+/1TV4tT3MBY=
X-Gm-Gg: ASbGncv4F818RNB0xQEgQE8QuRPi5xQwwXLrZ7nlu/tQqhTs0oWVrT7cPljHIphaneb
	Ho3CNKjexFJIdaIRUqOuzOhwQZwm3gQjvKTVySBvO+F+2+veFelneuBxFdAJaYBTYUx4jUvh4Te
	ey2qmoXHexG/aeq5gf7Vo0t0TxAxMliQbsj5Wj5K+svypFlgq31Ds/xy3AYBV2QsayVNt+0x04b
	tXscckDgQhSqoL+tHa6UMZl7n2TKY0NMxHw0b7PcO4AzsP1ALNwkKux3cTk9LV4kzShZCCgJm0b
	EyFYOwVGBHAFKj6iF/70kkl/LI+J5F+/cb3srwnpVOFl+t5nJa12+WSsau4cWu3UMPQs4RiNND7
	YbvUIA98ZibYn+1B9zBPF8eeHFCo=
X-Google-Smtp-Source: AGHT+IGRlrJL/hMg2fvOfjrwxfuiOfMWO4VNgYqpwRsWHXMQIhRsVFY7GAkc+zMu0TB3KTQQDEX5sw==
X-Received: by 2002:a05:6000:288e:b0:3b7:895c:1562 with SMTP id ffacd0b85a97d-3c5da83c60dmr22817307f8f.11.1756477074430;
        Fri, 29 Aug 2025 07:17:54 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-45b74950639sm94583545e9.17.2025.08.29.07.17.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 07:17:53 -0700 (PDT)
Date: Fri, 29 Aug 2025 17:17:50 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: stable@vger.kernel.org
Cc: djakov@kernel.org, naresh.kamboju@linaro.org, lkft@linaro.org,
	nathan@kernel.org, kees@kernel.org, konradybcio@kernel.org,
	quic_okukatla@quicinc.com, quic_rlaggysh@quicinc.com,
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] interconnect: qcom: icc-rpm: Set the count member before
 accessing the flex array
Message-ID: <aLG2jl7bwYVEoumO@stanley.mountain>
References: <20241203223334.233404-1-djakov@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241203223334.233404-1-djakov@kernel.org>

Hi Greg,

Could you pick up this commit for 6.12 and 6.6:

00a973e093e9 ("interconnect: qcom: icc-rpm: Set the count member before accessing the flex array")

It just silences a UBSan warning so it doesn't affect regular users, but
it helps in testing to silence those warnings.  It is a clean cherry-pick.

regards,
dan carpenter


On Wed, Dec 04, 2024 at 12:33:34AM +0200, djakov@kernel.org wrote:
> From: Georgi Djakov <djakov@kernel.org>
> 
> The following UBSAN error is reported during boot on the db410c board on
> a clang-19 build:
> 
> Internal error: UBSAN: array index out of bounds: 00000000f2005512 [#1] PREEMPT SMP
> ...
> pc : qnoc_probe+0x5f8/0x5fc
> ...
> 
> The cause of the error is that the counter member was not set before
> accessing the annotated flexible array member, but after that. Fix this
> by initializing it earlier.
> 
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Closes: https://lore.kernel.org/r/CA+G9fYs+2mBz1y2dAzxkj9-oiBJ2Acm1Sf1h2YQ3VmBqj_VX2g@mail.gmail.com
> Fixes: dd4904f3b924 ("interconnect: qcom: Annotate struct icc_onecell_data with __counted_by")
> Signed-off-by: Georgi Djakov <djakov@kernel.org>
> ---
>  drivers/interconnect/qcom/icc-rpm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
> index a8ed435f696c..ea1042d38128 100644
> --- a/drivers/interconnect/qcom/icc-rpm.c
> +++ b/drivers/interconnect/qcom/icc-rpm.c
> @@ -503,6 +503,7 @@ int qnoc_probe(struct platform_device *pdev)
>  			    GFP_KERNEL);
>  	if (!data)
>  		return -ENOMEM;
> +	data->num_nodes = num_nodes;
>  
>  	qp->num_intf_clks = cd_num;
>  	for (i = 0; i < cd_num; i++)
> @@ -597,7 +598,6 @@ int qnoc_probe(struct platform_device *pdev)
>  
>  		data->nodes[i] = node;
>  	}
> -	data->num_nodes = num_nodes;
>  
>  	clk_bulk_disable_unprepare(qp->num_intf_clks, qp->intf_clks);
>  

