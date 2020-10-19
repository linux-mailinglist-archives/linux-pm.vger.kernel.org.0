Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B80F32920B7
	for <lists+linux-pm@lfdr.de>; Mon, 19 Oct 2020 02:39:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbgJSAjj (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 18 Oct 2020 20:39:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726219AbgJSAjj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 18 Oct 2020 20:39:39 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9D2DC061755;
        Sun, 18 Oct 2020 17:39:37 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id z2so11974915lfr.1;
        Sun, 18 Oct 2020 17:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Qx3NEWybPIIcpRPU0RjxowfCLUNO17J0R2zpHsHrHuM=;
        b=qiW4Ym6xIODR0jBS9Ke/13G8/Zr1Hj/oqEeGz7++CWtznCS3KrcQSVcnYm4tYdUBBo
         xkeBeO8vqyn48v+VgDeFTIdm2TB/fobnh1KwyggECE9ZJwBdo9kOAegNv8n/vWwDda/M
         lOhiSpZx4OtwuQSDeq2SjkYsfLKUWpMSeBRara4+tU1sXsgydEjnTb3t7QO2KwTKB29p
         cMm5SDPVX86auql8HYNmhAwHV4KKa+mI1gxysdalAWcX7ohh9JjQGciiPNXRadb2b/2/
         yj5vaamHEhaKXQGoaL21+M3oDvLQmvpuE8gPUDToR98jODqZpEVXkylBgsF7AVMNu+Ns
         hTHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Qx3NEWybPIIcpRPU0RjxowfCLUNO17J0R2zpHsHrHuM=;
        b=rXwyOS1tvzR4kQ+e1YxnwO7VDChAMsPPCfdwd/3LT/jAiajP9iwjsoI1qt/lLt7/CT
         X0lvkKiUyKpGcPKY7IebI/w4UsgvkJnoGmWffYD0LH5yQp4iLqVBzPjcQBzL4wy9WskV
         +DpEZdS0CWeOY2EjbDoJ2O1xPeEAJo2Hm8xa6pzQ8FkCIpcgRjxawLmVsZTDYcYcgt+Q
         xPekNw31hTd3sx/A5FRAQvrKJDRf2mctCoLOVSuxk441e11DjDigT4VV5Vkhr7pAofft
         JiD6lcYdg78v2SV4mM4r9Jn20B0iJn5AkZHS2MLlq6N6IQTQP1pQ9zh5Gf0Q4Ea1B+/B
         mssQ==
X-Gm-Message-State: AOAM531hW7A+5lfyQNIbyS4ot86+CQ7chTrQR5IMvko4QdKZnoXx1kXO
        MpWedD4dazDomRH5TAVPOeM=
X-Google-Smtp-Source: ABdhPJzznrmLsrw5ddoK/b4xzFvme0jlLhnd0NPqSsGjd9EdOAuY07ZF0VNDgdCY4V3r33uEBS09dQ==
X-Received: by 2002:ac2:58e9:: with SMTP id v9mr4564556lfo.557.1603067976365;
        Sun, 18 Oct 2020 17:39:36 -0700 (PDT)
Received: from [192.168.2.145] (109-252-193-186.dynamic.spd-mgts.ru. [109.252.193.186])
        by smtp.googlemail.com with ESMTPSA id b10sm2023467lji.24.2020.10.18.17.39.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Oct 2020 17:39:35 -0700 (PDT)
Subject: Re: [PATCH v3 2/2] PM / devfreq: Add governor attribute flag for
 specifc sysfs nodes
To:     Chanwoo Choi <cw00.choi@samsung.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Cc:     leonard.crestez@nxp.com, lukasz.luba@arm.com,
        enric.balletbo@collabora.com, hl@rock-chips.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com, abel.vesa@nxp.com,
        k.konieczny@samsung.com, b.zolnierkie@samsung.com,
        chanwoo@kernel.org, myungjoo.ham@samsung.com,
        kyungmin.park@samsung.com
References: <20201007050703.20759-1-cw00.choi@samsung.com>
 <CGME20201007045340epcas1p3b4d0f9187f5330a45d20d9d9b79f1767@epcas1p3.samsung.com>
 <20201007050703.20759-3-cw00.choi@samsung.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <4cb8ece7-9399-9ee0-5f93-6c19630308d6@gmail.com>
Date:   Mon, 19 Oct 2020 03:39:35 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201007050703.20759-3-cw00.choi@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

...
> @@ -1361,6 +1373,9 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
>  		goto out;
>  	}
>  
> +	remove_sysfs_files(df, df->governor);
> +	create_sysfs_files(df, governor);
> +
>  	prev_governor = df->governor;
>  	df->governor = governor;
>  	strncpy(df->governor_name, governor->name, DEVFREQ_NAME_LEN);
> @@ -1460,39 +1475,6 @@ static ssize_t target_freq_show(struct device *dev,
>  }

The further code may revert df->governor to the prev_governor or set it
to NULL. The create_sysfs_files(df->governor) should be invoked at the
very end of the governor_store() and only in a case of success.
