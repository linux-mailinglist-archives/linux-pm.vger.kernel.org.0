Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 855B929828A
	for <lists+linux-pm@lfdr.de>; Sun, 25 Oct 2020 17:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1417166AbgJYQbN (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 25 Oct 2020 12:31:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1415317AbgJYQbM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 25 Oct 2020 12:31:12 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D5CBC061755;
        Sun, 25 Oct 2020 09:31:12 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id a9so8755175lfc.7;
        Sun, 25 Oct 2020 09:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ay1JGMinGji3rsAuVtxFdsPpdyNO+mG2wYCgwnbQSQA=;
        b=kWKE2oUBonMiIiIrJVLITWUQszX3f+2InFH9SZLK4BCeDXCGdYH5s/cUC4c0iTxLCG
         RIuV03ixqmcG6iUUHPrefHxqnbBmVJ0eUYnXMQAPOvbZ9AWk1Py934k3Mh+UMg9S1WSp
         h9P9YQnydFEeS2JNUez0LdK8SOsCz2a0edGD4gyLqPCOR0o3VkQOx0Xh6StRj4BBuHHP
         33adMLUNoBNDFRXx0yG4h4MDisdypI7JT+G1XiFtOeFYNTF5Xy/9VA0GGUOoPlfGqwce
         1acheooVqDaTEsmGrj4JG52Nibeo1FQmDuoUksfEviGu58M6t2ZQ2h+iJ4xTJIrCxIBz
         5MhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ay1JGMinGji3rsAuVtxFdsPpdyNO+mG2wYCgwnbQSQA=;
        b=Hrv0yPIbi2eHYAk3A+Xi002/HHpZOQtXotgD8HIkfZ4mnBlpj4AiR3PLfIYv+CdyGd
         6afp2IYu7plRKYNGLBKThlfjbo+Rs70nr/jDdX2CywCDNT+S5rQEz20SjmS7zE1QWCMM
         ndNhrkrRc0JhiC1nQHPyg0b4E+y70SH6H9wS+5OeB7Sk5NZ7Eqs67xnDHKU2AYLqaJae
         h3Nmpq5qxIwe9dnEK6dAL0eLRe5ztTMQfQwLJNH8iCkf6lSgSE0Ipslna82qVF1ZimYP
         6dsA2EmyX6qHbE8/CNmO8c5JpbFvry2vu/viK3YUWOIa+CC4vDoWdl8mnxSi6FmMRgaH
         WCFQ==
X-Gm-Message-State: AOAM530sEkOW0xq6f7KW44RJePKAKB51ovxJDgR05xFa7WtDMYYT/b5w
        U7tLGSTS4/cjRq/DgFRRzXM=
X-Google-Smtp-Source: ABdhPJxuO/bzJr90hmYvFfurekJABpXjvTrwzcsQLUdfUQXX6F7/W8TgdKZptcalcMrmJNZDsiWfng==
X-Received: by 2002:ac2:4204:: with SMTP id y4mr4173952lfh.224.1603643470929;
        Sun, 25 Oct 2020 09:31:10 -0700 (PDT)
Received: from [192.168.2.145] (109-252-193-186.dynamic.spd-mgts.ru. [109.252.193.186])
        by smtp.googlemail.com with ESMTPSA id 189sm775785lfh.151.2020.10.25.09.31.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Oct 2020 09:31:10 -0700 (PDT)
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
Message-ID: <9a2c99d1-ef65-4d89-3740-90a3b60d4cd5@gmail.com>
Date:   Sun, 25 Oct 2020 19:31:09 +0300
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
> @@ -1401,8 +1423,13 @@ static ssize_t governor_store(struct device *dev, struct device_attribute *attr,
>  				"%s: reverting to Governor %s failed (%d)\n",
>  				__func__, df->governor_name, ret);
>  			df->governor = NULL;
> +			goto out;
>  		}
...
> +		create_sysfs_files(df, df->governor);
> +		goto out;

These two lines could be removed.

>  	}
> +	create_sysfs_files(df, df->governor);
> +
>  out:
>  	mutex_unlock(&devfreq_list_lock);

Otherwise looks good to me.

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
Tested-by: Dmitry Osipenko <digetx@gmail.com>
