Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A0BD337A88
	for <lists+linux-pm@lfdr.de>; Thu, 11 Mar 2021 18:13:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbhCKRMt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 11 Mar 2021 12:12:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229696AbhCKRMi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 11 Mar 2021 12:12:38 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8708C061574;
        Thu, 11 Mar 2021 09:12:37 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id f1so41011328lfu.3;
        Thu, 11 Mar 2021 09:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=3nZrNZAlQ7fNFVlB/ncHMU9Y9miXCLpFJ30rJ9BLUO0=;
        b=IVGXWiOD7hDdyxq2bFepgOqkWt0DZxmoYTw6XqGU6pEShXZewrfqA8T9tolPtSbIYk
         S61HsWxnZEuMEVPoj+gcBlWx/9Ptui0+iOe0QEoALTpTsCrelEg8NnWwnGqgJUuVKT2e
         MYWcWhkWVY0FaiH3MK86Cjht7SyzC3WVB2jsQZwbduTJjhZt/GhMjaEeER01bOQMGEi3
         n9Sxt5qLQoBbM948ZSoe0jqCReQnKbp5bhUDqWn/z0bs/9wqUVBw/D9OF36QH55DUQwT
         LB8eRKKvutTv2B60vgmfCsxkB452Z1s9/mUHObrL5moifmaYHxkzCuG9nMozc2chVxQY
         iSYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3nZrNZAlQ7fNFVlB/ncHMU9Y9miXCLpFJ30rJ9BLUO0=;
        b=PtiQwyA5o5rAwfNUwD+gCc1oKUhxaA7JWEiQKYKh8ZMaMQWNyYH1QEa6dbh0R/85f+
         4jbVuvclBb4SD4ZK1lmcRPmUF0U7vekvTI7WXH5kFG5H8WHaN59boPmhVExx/CYvssm3
         qVjRBJ4HSxI/c8WrUdaK1cwXMBYvCvLeNU1UU+PZhv56ozqblGzvDTsPWGKsTvjKliEW
         7LotQRG/WH4i60aDHolObVzpVR0fhRMfmv5NgsUEGr9oqaH3AbkjRJvzCJMRMQiycxQD
         rkGtGMNIeAgTks2ubUU2ua48kBTnzj5tEeJiAd6HXQsgWTSG94TxH7XHK5JCuu/3uUOZ
         sDtA==
X-Gm-Message-State: AOAM530oCHgi2HLtf/7XDT4X+CDSD8tTeIeCNG4H5o4dTk2ijLZsFMnt
        XqzClpi2reFyRnyqKlNr1dKLDAx0XB8=
X-Google-Smtp-Source: ABdhPJwT6mHPhMsF54uxKS8z3qLJNi9SUeGjUOLfvAmSHkBDOAhV/V5E7fdMr1abW61xPhdiTZqtEw==
X-Received: by 2002:a19:7fc3:: with SMTP id a186mr2691203lfd.626.1615482756315;
        Thu, 11 Mar 2021 09:12:36 -0800 (PST)
Received: from [192.168.2.145] (109-252-193-52.dynamic.spd-mgts.ru. [109.252.193.52])
        by smtp.googlemail.com with ESMTPSA id v70sm1004633lfa.106.2021.03.11.09.12.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Mar 2021 09:12:36 -0800 (PST)
Subject: Re: [PATCH v14 1/2] drm/tegra: dc: Support memory bandwidth
 management
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Matt Merhar <mattmerhar@protonmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Nicolas Chauvet <kwizart@gmail.com>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
References: <20210311170606.7543-1-digetx@gmail.com>
 <20210311170606.7543-2-digetx@gmail.com>
Message-ID: <37ff0499-6601-e97a-9fba-8e3e6f338b86@gmail.com>
Date:   Thu, 11 Mar 2021 20:12:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.2
MIME-Version: 1.0
In-Reply-To: <20210311170606.7543-2-digetx@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

11.03.2021 20:06, Dmitry Osipenko пишет:
> +static const char * const tegra_plane_icc_names[TEGRA_DC_LEGACY_PLANES_NUM] = {
> +	"wina", "winb", "winc", "", "", "", "cursor",
> +};
> +
> +int tegra_plane_interconnect_init(struct tegra_plane *plane)
> +{
> +	const char *icc_name = tegra_plane_icc_names[plane->index];
> +	struct device *dev = plane->dc->dev;
> +	struct tegra_dc *dc = plane->dc;
> +	int err;
> +
> +	if (WARN_ON(plane->index >= TEGRA_DC_LEGACY_PLANES_NUM) ||
> +	    WARN_ON(!tegra_plane_icc_names[plane->index]))
> +		return -EINVAL;

It just occurred to me that I added the NULL-check here, but missed to
change "" to NULLs. I'll make a v15 shortly.
