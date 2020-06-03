Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 88D041ECD36
	for <lists+linux-pm@lfdr.de>; Wed,  3 Jun 2020 12:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725943AbgFCKKO (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 3 Jun 2020 06:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725881AbgFCKKO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 3 Jun 2020 06:10:14 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA789C05BD43
        for <linux-pm@vger.kernel.org>; Wed,  3 Jun 2020 03:10:13 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id 64so1296476pfg.8
        for <linux-pm@vger.kernel.org>; Wed, 03 Jun 2020 03:10:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=NMA8UswHoR10ZkKb/xOBjfFah7opSPUF3++8T+IfxFs=;
        b=bbY2Dpz1nYTTpJmtv4MB4qZePaCtWdI2q0cWL16Ks+j0wZKR8/5Ks5hu4TPVUai1sr
         RYBRPO4yT9Wwkur4+WZRMT1CZ3rIvVrNEiparBSnRiDOx4HgDLldQ26qvGo2mgR+70MW
         +qD6UM9LZC1GqAPuvv3Om2jH99di6UMYJtvICVhDyQ4cVkXchRRpGdZhQT+FMPbg0Vif
         oDnFjOudHWJwuHzUq18DbSfR/TV442MJ2N/xa6Ch/Uj4O27wgsOLZVlTXb2zyu5hALVQ
         c7WL7a9RDlgB9qnUGHusQ+Ygqo9gzRZVMX/faO5lc1xArPgKQdwoA24EsDHFVvKxrTDp
         QyyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=NMA8UswHoR10ZkKb/xOBjfFah7opSPUF3++8T+IfxFs=;
        b=VLlqdfHlUJUmwqa6YtBadC9SigRrRNMMPaP56dl3T12GazODM3XbajdlHdsBkkaoBv
         5bTP2LYt6DtMik/NxEfWtAqYNrkJZImAaHM25uI9qKStUrBZc7BGowIodT8+wmqkRSBI
         H8oWEiUB6vYlV/vDUf4Ue/82/hiThcV0wOOngl/i2U9GWcAq73YqTdgTQZCUROR3JYp0
         9QuVmVDhIDoRxfZd6TNJznnhuMic0EjDBZrvT2346s844BgjhItxvpWQXh6JIC7f9mcw
         yLtURAd87w9AIsGcrIJt7cuZxej+VM31l48PBFJMVAMII8AcexkdRnrLo/8SXEYh3ru/
         7v+g==
X-Gm-Message-State: AOAM532L4cFlAFMVzcpi/ADPFbzj0VJd7hZ+5j/jX0Pv0vXwfMqdUwPl
        xCswPraCLfsYUDBvAFKX3SktDA==
X-Google-Smtp-Source: ABdhPJxkZFOpVSUQKBvnC0ohU+GJ++eICExvZmctfWCbjff/g0JyLwrXZZFZxU+HAISkO3HyZGHNww==
X-Received: by 2002:aa7:96d7:: with SMTP id h23mr14182341pfq.320.1591179013326;
        Wed, 03 Jun 2020 03:10:13 -0700 (PDT)
Received: from localhost ([122.172.62.209])
        by smtp.gmail.com with ESMTPSA id w6sm1947722pjy.15.2020.06.03.03.10.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Jun 2020 03:10:12 -0700 (PDT)
Date:   Wed, 3 Jun 2020 15:40:10 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     Xiongfeng Wang <wangxiongfeng2@huawei.com>, rjw@rjwysocki.net,
        guohanjun@huawei.com, ionela.voinescu@arm.com,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Question]: about 'cpuinfo_cur_freq' shown in sysfs when the CPU
 is in idle state
Message-ID: <20200603101010.alijrfmte2c6xv5c@vireshk-i7>
References: <f1773fdc-f6ef-ec28-0c0a-4a09e66ab63b@huawei.com>
 <20200603075200.hbyofgcyiwocl565@vireshk-i7>
 <20200603100727.GB7259@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200603100727.GB7259@bogus>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 03-06-20, 11:07, Sudeep Holla wrote:
> But I have another question. If we can detect that CPPC on some platforms
> rely on CPU registers(I assume FFH registers here and not system/io/...
> type of GAS registers), can we set dvfs_on_any_cpu(can't recall exact
> flag name) to false if not already done to prevent such issues. Or I am
> talking non-sense as it may be applicable only for _set operation and

          Yes, non-sense :)

> not _get.

-- 
viresh
