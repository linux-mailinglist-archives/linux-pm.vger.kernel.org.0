Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27ACE4F9E71
	for <lists+linux-pm@lfdr.de>; Fri,  8 Apr 2022 22:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236707AbiDHU4o (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 8 Apr 2022 16:56:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234040AbiDHU4n (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 Apr 2022 16:56:43 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F04513F9A
        for <linux-pm@vger.kernel.org>; Fri,  8 Apr 2022 13:54:38 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id s8so9394481pfk.12
        for <linux-pm@vger.kernel.org>; Fri, 08 Apr 2022 13:54:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=s2fZHIotgsxswHvP6sguOxIbmh2IU0gAkJkvl8us6mg=;
        b=kSFN4A0aUO7j8SQVn5H/Fqr4jiYtS3UROq0rDlzzLesv4zln2QvOKFdhoBiD9nrnC/
         ly6HOweBb7Y5mjm30ZI8ER4Re7zKQSAGymlBiqijlENVEIFYc2ZzF5hFv8CvosOQL9lc
         lC5sjl4V1mY5YoZsvNeeBGsn0cHuojNJtdav3e8b9n3m90EyJ3EvkcY17N5xM6EifeKI
         ZcUvor38Bav3ISeUKVY4+7HmiA4Vugkp8gijpYdcN+hHV249zDdfnXZH1+welko7hklG
         PKbutjw0UbA3REDa4Md8VLUI2Ol/jr9gYv+b86jyY/fpCBngvmZPhPAoaG5BjgUApDN7
         BeDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=s2fZHIotgsxswHvP6sguOxIbmh2IU0gAkJkvl8us6mg=;
        b=3n5MokwrKXqbF4HA6EprO2KsMflNxdrjrw4W/vi9hjlhli43OS4+NlgpMLF1dhx/Tg
         L0hgJ1G0vCqPhoSWjnxK/xbaLgB7C16VKtmxekubYA5DTIfbcGsOD7mMlfJLrooSb3D3
         dzr309AW9EAWU7mbAFK3grDMNSl/XWqVmM0MrKZ79pWAzniOOMqyTI8TZfBWxI0TbNRu
         KiQga/4QM8G3A6/+U1QLlskLtOb+lLJ3zveJqObX5pTW3mBfZlil+XYi6EmRS4AyFt8k
         RxcLXYwiJh0xpXiiJ2BsZYN57gqh6pUP3RdDNerwsfYugBF5Kkxy38xyChn7+mGB+UpZ
         wLmw==
X-Gm-Message-State: AOAM533/srrKSdm9eoqgEslPEdqJl9yjWt+7o4XytoWrBMBv5fBfTaOz
        GEj5oSWvIHfJ6MJkKBqKG1NFOg==
X-Google-Smtp-Source: ABdhPJzl2qcM0uP6/pCLd+oZzLdz9tDMXdCr5zj20GepMe5DR+cWERKZFDNS6wBxjC7dH6BrquqL6w==
X-Received: by 2002:a63:121d:0:b0:39c:c252:135a with SMTP id h29-20020a63121d000000b0039cc252135amr9281357pgl.289.1649451277433;
        Fri, 08 Apr 2022 13:54:37 -0700 (PDT)
Received: from localhost (c-71-197-186-152.hsd1.wa.comcast.net. [71.197.186.152])
        by smtp.gmail.com with ESMTPSA id s35-20020a056a001c6300b004fb20b5d6c1sm26732009pfw.40.2022.04.08.13.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Apr 2022 13:54:37 -0700 (PDT)
From:   Kevin Hilman <khilman@baylibre.com>
To:     Rex-BC Chen <rex-bc.chen@mediatek.com>, rafael@kernel.org,
        viresh.kumar@linaro.org, robh+dt@kernel.org, krzk+dt@kernel.org
Cc:     matthias.bgg@gmail.com, jia-wei.chang@mediatek.com,
        roger.lu@mediatek.com, hsinyi@google.com, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
Subject: Re: [PATCH V2 13/15] cpufreq: mediatek: Link CCI device to CPU
In-Reply-To: <20220408045908.21671-14-rex-bc.chen@mediatek.com>
References: <20220408045908.21671-1-rex-bc.chen@mediatek.com>
 <20220408045908.21671-14-rex-bc.chen@mediatek.com>
Date:   Fri, 08 Apr 2022 13:54:36 -0700
Message-ID: <7hfsmn5m9f.fsf@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Rex-BC Chen <rex-bc.chen@mediatek.com> writes:

> From: Jia-Wei Chang <jia-wei.chang@mediatek.com>
>
> In some MediaTek SoCs, like MT8183, CPU and CCI share the same power
> supplies. Cpufreq needs to check if CCI devfreq exists and wait until
> CCI devfreq ready before scaling frequency.
>
> - Add is_ccifreq_ready() to link CCI device to CPI, and CPU will start
>   DVFS when CCI is ready.
> - Add platform data for MT8183.
>
> Signed-off-by: Jia-Wei Chang <jia-wei.chang@mediatek.com>

The checks here are not enough, and will lead to unexpected behavior.
IIUC, before doing DVFS, you're checking:

1) if the "cci" DT node is present and
2) if the driver for that device is bound

If both those conditions are not met, you don't actually fail, you just
silently do nothing in ->set_target().  As Angelo pointed out also, this
is not a good idea, and will be rather confusing to users.

The same thing would happen if the cci DT node was present, but the CCI
devfreq driver was disabled.  Silent failure would also be quite
unexpected behavior.  Similarily, if the cci DT node is not present at
all (like it is in current upstream DT), this CPUfreq driver will
silently do nothing.  Not good.

So, this patch needs to handle several scenarios:

1) CCI DT node not present

In this case, the driver should still operate normally.  With no CCI
node, or driver there's no conflict.

2) CCI DT present/enabled but not yet bound

In this case, you could return -EAGAIN as suggested by Angelo, or maybe
better, it should do a deferred probe.

3) CCI DT present, but driver disabled

This case is similar to (1), this driver should continue to work.

Kevin
