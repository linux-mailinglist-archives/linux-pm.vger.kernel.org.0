Return-Path: <linux-pm+bounces-5444-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 777CC88CDFD
	for <lists+linux-pm@lfdr.de>; Tue, 26 Mar 2024 21:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3172C322822
	for <lists+linux-pm@lfdr.de>; Tue, 26 Mar 2024 20:13:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91BD13D50C;
	Tue, 26 Mar 2024 20:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YxSVHsDT"
X-Original-To: linux-pm@vger.kernel.org
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE36613D28F
	for <linux-pm@vger.kernel.org>; Tue, 26 Mar 2024 20:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711484002; cv=none; b=o9Cex586XuQTXi1UeugO3Jpps5QX2w/vKi+yFsw5jO+/JBN1F4X7BnAYuU22U7E0w6AWl5QSAQCY6llvusXKLrrsNaKjjDTD5gMW54ZlDCnIxJKBoHawVuu2DrcnneY+deH/CY2XgTydAN6WDTja091BYv4BRB1SJs03OvBNXV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711484002; c=relaxed/simple;
	bh=btunXKwgkufCO7HD+m8VJEh9e4JqDOX4/d3qyOulTA8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dADtkuyTgQq0e8VjBMHjtEe9lZBU4jwhPeC0jalt6jK2flLhZA2Hlkdk6LoNqSkCS6oTh83Xtor9OdHLwAHRatl95/3iYJM2qp6jE+ul9JfGCiKseOr2/RUyAhiNEvwS4ZPMgkbzOoGUnK8GTM+uGj4RWK2eDcL/oM4kMcW9o18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YxSVHsDT; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dcc84ae94c1so5720828276.1
        for <linux-pm@vger.kernel.org>; Tue, 26 Mar 2024 13:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711483999; x=1712088799; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UbYSMMZKtzawfJDJE4cir49VqhmCQiE1LJhdXx2FwYw=;
        b=YxSVHsDTPGIouqPy5YnQfc4NLv2Xe7U54N3RH+K8OaERQL6XR1h6YWhMOR2y4jM0Hj
         4/e24S25rukMeHVEGZqJoC6Sn8I/fxSYRCXRvdpRZozRfRk2DdW1oQBd+R5dcAIkZI1d
         hvNGH2q4A5Y02FzS/bb/ui8Rbbi5NWPknBqc4tFKzHQeM12ou1NSXTLT0MqhI/1FHq6d
         kakkthDG3QcO8a4CwZWGnjPGIXWO5NPy8Y1H3HQvYnFkAq8h/THE+Yqehmfg47KLAZ+s
         2UatPvhX5rUQPzvtc4EA57f9CkykU7YyKjBWguXlHImDRpicAQgFdXSk8v92G3ZZ1PMf
         5Nqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711483999; x=1712088799;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UbYSMMZKtzawfJDJE4cir49VqhmCQiE1LJhdXx2FwYw=;
        b=II7pb0gndOoDoVsNpDHAuJZreCeP2Z/iFccLHBAlsvXajvc7Wbyjczbl4bJ/pdxE7r
         mkmM/7vhNCUGHncb75feqVlcUO4dRBYW/voOEQxVvHn48hSYtVMZzKIb4vNC64bNEGAd
         sOhwDSe6pRj/DbMLYExki/MSwUy5ifiO56CPGca9LADvz/BLup+8j9Vf/WnN2ETY3kfv
         y8bOJ4i/2PrMTsqhbBk6k1MoEhM+WK9MgVX6u4ndY8Tm1YLNKy6u4yz/vnaEMAdWuh5t
         igk1+UQMg2JZIYL6WHaq+71bTD8Pq0awap8+UXSKXL1zwlMxoazZnl6cqXUFhb9YyoOj
         eL0w==
X-Forwarded-Encrypted: i=1; AJvYcCWUMM3JcrdQNketWkCHyBbcQwk0izHeSTW2A1H7m6T9Gr1MG9GSvJzt9eSrevCRZQ2sxeF0u/MzLu+qpgtAQyyfpgRxKMUF3TA=
X-Gm-Message-State: AOJu0YwXBUSZvjB2AIl7X4aDRZ9fsoP2GL5SNT6IbJgEFVMLlRa4Er24
	/K49qsCkDpPhUxOm7kNHIbNnUX9rKYHenPIYjnBwxo0mdrFOJH5NakiwKbhXFNuetNvJil4mLuK
	Hfhht6Myw7D09SSraDFn5ZajUSSQFcpzT2cjTmQ==
X-Google-Smtp-Source: AGHT+IFFX483t90XKNX+OO769dAgkkQ3Mdks7uUfVPLNLZ5sWIKnzmWcN1zXVl0obYk/iP34XbMH5Mhww+pfc58YeU8=
X-Received: by 2002:a25:c7ca:0:b0:dcc:623d:e475 with SMTP id
 w193-20020a25c7ca000000b00dcc623de475mr3650511ybe.30.1711483998811; Tue, 26
 Mar 2024 13:13:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240326-topic-rpm_icc_qos_cleanup-v1-0-357e736792be@linaro.org> <20240326-topic-rpm_icc_qos_cleanup-v1-1-357e736792be@linaro.org>
In-Reply-To: <20240326-topic-rpm_icc_qos_cleanup-v1-1-357e736792be@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 26 Mar 2024 22:13:07 +0200
Message-ID: <CAA8EJpo=JScW9ksFtq_rzvJKue_1bVcK2oiA5ZfjpyD=F3wNZA@mail.gmail.com>
Subject: Re: [PATCH 1/4] interconnect: qcom: sm6115: Unspaghettify SNoC QoS
 port numbering
To: Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Georgi Djakov <djakov@kernel.org>, 
	Shawn Guo <shawn.guo@linaro.org>, Marijn Suijten <marijn.suijten@somainline.org>, 
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Stephan Gerhold <stephan@gerhold.net>
Content-Type: text/plain; charset="UTF-8"

On Tue, 26 Mar 2024 at 21:43, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
> When I was creating this driver, my bright mind overlooked the existence
> of desc->qos_offset and decided to make up for the difference it made by
> adding 21 (0x15) to the port index on SNoC and its downstream buses.
>
> Undo this mistake to make the indices actually mean something.

So, what is the meaning of qos_port?

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/interconnect/qcom/sm6115.c | 33 ++++++++++++++++++---------------
>  1 file changed, 18 insertions(+), 15 deletions(-)
>
> diff --git a/drivers/interconnect/qcom/sm6115.c b/drivers/interconnect/qcom/sm6115.c
> index 7e15ddf0a80a..271b07c74862 100644
> --- a/drivers/interconnect/qcom/sm6115.c
> +++ b/drivers/interconnect/qcom/sm6115.c
> @@ -242,7 +242,7 @@ static struct qcom_icc_node crypto_c0 = {
>         .id = SM6115_MASTER_CRYPTO_CORE0,
>         .channels = 1,
>         .buswidth = 8,
> -       .qos.qos_port = 43,
> +       .qos.qos_port = 22,
>         .qos.qos_mode = NOC_QOS_MODE_FIXED,
>         .qos.areq_prio = 2,
>         .mas_rpm_id = 23,
>


-- 
With best wishes
Dmitry

