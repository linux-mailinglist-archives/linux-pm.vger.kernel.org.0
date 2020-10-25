Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75495298288
	for <lists+linux-pm@lfdr.de>; Sun, 25 Oct 2020 17:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1417179AbgJYQaP (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 25 Oct 2020 12:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1417102AbgJYQaO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 25 Oct 2020 12:30:14 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217F3C0613CE;
        Sun, 25 Oct 2020 09:30:14 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id 184so8755443lfd.6;
        Sun, 25 Oct 2020 09:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=z0zykOKZGfO9IJ1VG4O1+prBfhkSWlv4n1wlWSYuL7U=;
        b=lcdAKibzCCw8h/iR1e4SRioc5XLYJtrb66zdOjz/pdTpnrWkzJME3zSFjwqWl8bQPU
         SvjO7FZJWrkkLz7lWDn+u668y9DfANcM6X30rsMIBflmxU5fOqD70zt2WdDPuRtVPRqY
         bmCqokXB9RRVuDGeAnIvXeNDm0wvj0JDEJY99rXgH3OSnKhM8KccRunPnNv3FZPqJobM
         R/hayWQP070k7cIobR6Ilo7JB/2UpHGYuLFm13JPcz+4yL83JVz060XCADPgVGA/ELHK
         MIHfXCCmIQyKwvUg7fqBYoNxG7mqQbx32rgmU8Mdc/Mmt6dEf5VP+9WCultnra8GQiap
         JJ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=z0zykOKZGfO9IJ1VG4O1+prBfhkSWlv4n1wlWSYuL7U=;
        b=I8M2Umn8WLBoW5gsR/PX6V9VGuwURESI5VF31JmhCc3m44w4IFVtiRIGC/BFb2Op7U
         TD1gYSwaZ34LeP9K2CpgfNrMfTgxL8Z3b/Rv9CIiEF767oKhdlDwk1q8+v11l/Sxd2C+
         ZJgpeR48bqCmZxAZaY0TE0Z+DqNbfy3MUkRNxVI8E0ooBJ/kSKFLSK95iNMuB9gvoChQ
         236i2egE3RtE8r6tuT546jmIem5h4PXXwy/EidgA1FEhOsRoiz0AFrXX4bWLh6mmvmeP
         nMN3GsqhBRTJqiU7y4WweYG5y1QdFdbb7cylDrwsnqLLmQW5aBRE9bhmB14P8D17bIyN
         9aVw==
X-Gm-Message-State: AOAM533sPs1EoYdqDmbN1ebJg2/Xj5m4h3WWw50pzzoIdvwpdRDvp2lf
        rQm8enxwmSnlJSbRP2gHzhM=
X-Google-Smtp-Source: ABdhPJwYRSFfSbb64z2FMcJI/2tZqIZA1HfUHjy5FpoPPthIPvSU91hpZGad9oVtJuuv+6palHJIIg==
X-Received: by 2002:ac2:5dd5:: with SMTP id x21mr3520875lfq.41.1603643412663;
        Sun, 25 Oct 2020 09:30:12 -0700 (PDT)
Received: from [192.168.2.145] (109-252-193-186.dynamic.spd-mgts.ru. [109.252.193.186])
        by smtp.googlemail.com with ESMTPSA id 9sm858656lju.128.2020.10.25.09.30.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Oct 2020 09:30:12 -0700 (PDT)
Subject: Re: [PATCH v5 2/2] PM / devfreq: Add governor attribute flag for
 specifc sysfs nodes
To:     Chanwoo Choi <cw00.choi@samsung.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Cc:     lukasz.luba@arm.com, enric.balletbo@collabora.com,
        hl@rock-chips.com, thierry.reding@gmail.com, jonathanh@nvidia.com,
        abel.vesa@nxp.com, k.konieczny@samsung.com,
        b.zolnierkie@samsung.com, chanwoo@kernel.org,
        myungjoo.ham@samsung.com, kyungmin.park@samsung.com
References: <20201023102632.740-1-cw00.choi@samsung.com>
 <CGME20201023101247epcas1p14b14dc1be24842daac1dc7bd229d4570@epcas1p1.samsung.com>
 <20201023102632.740-3-cw00.choi@samsung.com>
From:   Dmitry Osipenko <digetx@gmail.com>
Message-ID: <53199cd1-772c-f30e-4f74-93572d6875cb@gmail.com>
Date:   Sun, 25 Oct 2020 19:30:11 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201023102632.740-3-cw00.choi@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

23.10.2020 13:26, Chanwoo Choi пишет:
> @@ -909,6 +915,8 @@ struct devfreq *devfreq_add_device(struct device *dev,
>  		goto err_init;
>  	}
>  
> +	create_sysfs_files(devfreq, governor);
> +
>  	devfreq->governor = governor;
>  	err = devfreq->governor->event_handler(devfreq, DEVFREQ_GOV_START,
>  						NULL);

Shouldn't sysfs be created *after* GOV_START? This is inconsistent with
governor_store().
