Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02D8B131FBD
	for <lists+linux-pm@lfdr.de>; Tue,  7 Jan 2020 07:16:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727181AbgAGGPw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 7 Jan 2020 01:15:52 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:46427 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725781AbgAGGPw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 7 Jan 2020 01:15:52 -0500
Received: by mail-pl1-f196.google.com with SMTP id y8so22759739pll.13
        for <linux-pm@vger.kernel.org>; Mon, 06 Jan 2020 22:15:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MBx9eiA7wdbP2nqN4M3UGU6OsOENkr/rr6Is0HWpxds=;
        b=XwggVHZcy506JAqUq09CKNV1Rb6ZxjlDDbchXEKlCSq2v9z6sbN7x9ChC7vhJu5tJN
         VF1NLx39RLNhMmGlyM6FY/sPShVoMT4z6umO7Bjp5uPp7iEzh2WtgatpVi3LEGnDMEwc
         abNdlnv5rG5VoFcD7GmuLivlrvsZ/ZZZWcLxMEp26QOJRRKy1j1uIgZtf7+OUlx5BEHl
         1Tvxq/ysrSQAsOrz9WVci7aUjB6VPcCYsvYrjoXX9zJo//iK8GRU8Dg5a9cNy8jcirfG
         0H602t4Y18Dq2X+DstmoGCaERbSZcP90Lx4CwtW80u739330aoV2aIgnkfPDhO5LF2bL
         +zQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MBx9eiA7wdbP2nqN4M3UGU6OsOENkr/rr6Is0HWpxds=;
        b=f7F7LiYGIFrT+rLIcxmiowz1pk5U4a2I3QxywlZePAZRG8keM9j7Xw5ZJa6LbqUI8Z
         xneVwZhPPHYXxEWlSoaDdIF3ouQIEibYMxYky1S1sp7lPEOAGkpZmsl921BpNHuWXY7W
         2U433KHmunX7kSBVp8HqRaZ/o0nYabc7k7Fgq0quRH9Nn6Y9XBg8dde3Q8lDl6QeliUN
         SWNo2JmjRf7L4a1V+HcrAVCwNelJXcPn0cLybS2cl4BOgDdhsP+W718ELm2uvSXVhVYQ
         DM3IShGiK6s6w9nFBB1gtocyFKFatWuZON16AvYCnx8JHA3ShjcV2BQlyRfp2K/BW4PM
         5bcQ==
X-Gm-Message-State: APjAAAX9qk4+5GHQ1Gp8on0Dbu3aHlF2sYGoG9t2fa8bGkC2IbspKOOX
        UQzb1i2GQSURIDBXtyvSkIGGBA==
X-Google-Smtp-Source: APXvYqwyDYa50TpzPvKGvUa/ah7QsaRLTzy0lR6hpMbfVCtnPhOf1OCj7psBYGjh7/IeGvosgHflQA==
X-Received: by 2002:a17:90a:cb83:: with SMTP id a3mr46740958pju.80.1578377751772;
        Mon, 06 Jan 2020 22:15:51 -0800 (PST)
Received: from yoga (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id q7sm26643097pjd.3.2020.01.06.22.15.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jan 2020 22:15:51 -0800 (PST)
Date:   Mon, 6 Jan 2020 22:15:48 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Georgi Djakov <georgi.djakov@linaro.org>
Cc:     linux-pm@vger.kernel.org, evgreen@chromium.org,
        daidavid1@codeaurora.org, okukatla@codeaurora.org,
        jcrouse@codeaurora.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] interconnect: Check for valid path in icc_set_bw()
Message-ID: <20200107061548.GC716784@yoga>
References: <20200106172746.19803-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200106172746.19803-1-georgi.djakov@linaro.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon 06 Jan 09:27 PST 2020, Georgi Djakov wrote:

> Use IS_ERR() to ensure that the path passed to icc_set_bw() is valid.
> 

Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
> ---
> v2:
> - Use WARN_ON() instead of pr_err() (Bjorn)
> 
>  drivers/interconnect/core.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/interconnect/core.c b/drivers/interconnect/core.c
> index 63c164264b73..d2ba5ae7d25b 100644
> --- a/drivers/interconnect/core.c
> +++ b/drivers/interconnect/core.c
> @@ -495,9 +495,12 @@ int icc_set_bw(struct icc_path *path, u32 avg_bw, u32 peak_bw)
>  	size_t i;
>  	int ret;
>  
> -	if (!path || !path->num_nodes)
> +	if (!path)
>  		return 0;
>  
> +	if (WARN_ON(IS_ERR(path) || !path->num_nodes))
> +		return -EINVAL;
> +
>  	mutex_lock(&icc_lock);
>  
>  	old_avg = path->reqs[0].avg_bw;
