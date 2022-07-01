Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E59D2562BF1
	for <lists+linux-pm@lfdr.de>; Fri,  1 Jul 2022 08:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234614AbiGAGoR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 1 Jul 2022 02:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiGAGoQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 1 Jul 2022 02:44:16 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDB7133A1F
        for <linux-pm@vger.kernel.org>; Thu, 30 Jun 2022 23:44:14 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id q18so1473914pld.13
        for <linux-pm@vger.kernel.org>; Thu, 30 Jun 2022 23:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=fqGOYzB/l7kZK+g2PKZOtqROPoLcRVD866dnEs5oBmg=;
        b=S2RjsRb3GpYJqTgHxI6x24eL3axHi0Kfg9q59bm6bNShOPqNSkYNk7yLBGNEUzChmk
         VEWY3BfMLsWXPQYPVDSzMgUs6DmUIjxV1OSfVFGyhjGRflr88zCdsO9W1zGtBj/L41cc
         Ej563wqt8kAr9z6n/5ZyOfZQ/LrnFvfp+jp7+MkKO5kKQ1lbGz19wmAslM3ffDwD0qXg
         Eo6dOubjHp35YzZ7xLA8Zq/BK5UjR6dx0w/v1s+NBZZ6e/ycZ94iVJ4Tm5y+vozAv7QV
         aEIV3RSPEWCa2/aT3iIKsn/kZdH1wggTsXrtWDZF3QjmFORM9VKZndG7Xrv1vvDCnumS
         3C3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=fqGOYzB/l7kZK+g2PKZOtqROPoLcRVD866dnEs5oBmg=;
        b=rtRclPeNDgE9jNv+eUuYlLIti82WdjmCfnyKLM5WN5qA+AmRUZ87qvMX8qjW+gBFWQ
         YcGzuyj2F5kJF5JGggYVbQ+XvWI6Pi2eSVJP4iK/wjcyfrIxF7j7ra+HhUUBmyo7/1cC
         W309qtJ7hq7K90mcc53YVwq/WzXLwIKGkbqrA3mRR3O9nKj8xjl/3Fe/MiCCLKvyxAGX
         0AF/xt+sXj3ydmyffELkpJlm6iSLYcWT49CdM359dJEdsmP/QqKMibhsMzr0Fhb+x3Y3
         ES/WKdzQAdYxpUXzF/2ON1/+ordKmnLQFX7FzPkQE3RoLO2Eq5oeRTgn3LsbR75Nx0Vn
         JrLg==
X-Gm-Message-State: AJIora9JewtbtdoezKeN2uxIdQr9aLrezOpkDLc1AdmoHM1/+txx0tEH
        oIcb9otX32cjxeBSQxTUesVItA==
X-Google-Smtp-Source: AGRyM1uwyvmSGlGJAjXrdc6N6uZUQfJRuTlnB3J/YZbniZZrpCKhJ5r35ItliBXy8saLnoAV5x2zwQ==
X-Received: by 2002:a17:902:8501:b0:16b:8ec5:1bbd with SMTP id bj1-20020a170902850100b0016b8ec51bbdmr17918803plb.151.1656657854475;
        Thu, 30 Jun 2022 23:44:14 -0700 (PDT)
Received: from localhost ([122.172.201.58])
        by smtp.gmail.com with ESMTPSA id c19-20020a62e813000000b005252adb89b3sm14738580pfi.32.2022.06.30.23.44.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 23:44:14 -0700 (PDT)
Date:   Fri, 1 Jul 2022 12:14:09 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Yi Zhang <yi.zhang@redhat.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org
Subject: Re: [bug report] lscpu: cannot read
 /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq: Device or resource
 busy
Message-ID: <20220701064409.b3uefcbipd5doure@vireshk-i7>
References: <CAHj4cs9PPg7c=riv4OW9nTY_igFTNgX9Gm2a55ZAbVy+nB=LKg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHj4cs9PPg7c=riv4OW9nTY_igFTNgX9Gm2a55ZAbVy+nB=LKg@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

+Rafael and linux-pm

On 30-06-22, 19:37, Yi Zhang wrote:
> Hi Viresh
> 
> 
> I got this issue when I run lscpu after offline cpu0 on the server[1],
> and I'm using the latest linux tree.
> 
> [1]
> echo 0 >/sys/devices/system/cpu/cpu0/online
> lscpu: cannot read
> /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq: Device or
> resource busy

That is by design, if the last CPU of a policy goes away we don't
remove the sysfs entries right away, but disallow their access to
avoid any races later on.

> I get your mail address from MAINTAINERS, I'm not sure which should be
> the right maillist to report to, so only send to you.

-- 
viresh
