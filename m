Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD4E91D0F64
	for <lists+linux-pm@lfdr.de>; Wed, 13 May 2020 12:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732913AbgEMKKn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 May 2020 06:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732674AbgEMKKl (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 May 2020 06:10:41 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A26C061A0E
        for <linux-pm@vger.kernel.org>; Wed, 13 May 2020 03:10:40 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id g12so27800810wmh.3
        for <linux-pm@vger.kernel.org>; Wed, 13 May 2020 03:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:autocrypt:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HLNFbZ1pUXdpUu4uIHgZes4VhXZ3ubFdB8i3YmL6eQg=;
        b=gMQBgdnIMWxdQ281X69UXFiONU35q6BA2601uQGUEHpjqLi5V8HCyK4H8zFwxayomQ
         mJpAUrqL+E6M2zRhA3+ynOOKjOizz6VUdlyEjDsC3H1hftoopwObOU/bKxJX8xZxd6Di
         ndY+GQzvG94Aodppqte8cBTfQdV1crDDfSZkLq2IJIs0Rq7Pp1PcFUiUSgKBcoMzbTup
         A8J9ZJBzof9t6+H6X2OqlDZ2o/4ZL8y4/0cphFHirWpT1mmh79OxCeKN87cMHnMZ7DPP
         9B+K2b6BX4nLVlXlCVKPPHUV70yAkyIJrkGnOhyEg5Cn8ROoSGsz/dixpXEB7FBOKTu+
         ZU3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:autocrypt
         :message-id:date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HLNFbZ1pUXdpUu4uIHgZes4VhXZ3ubFdB8i3YmL6eQg=;
        b=DozmyGNafyLbVfpl6IsE2gI7HCDuTy2BJpgy18VwOuj6eoukOUgMXCp6bISsVHzyN6
         jZYDzxJPzOx29NtklgX+koD8hWFFenKs3Q2iPEacKO/Lz3aBotXo1ZVsMbLiDsv6W05p
         rS2ZR6GCobeWCJM4iR7eUVIjf/9PCoEb9OHUdt7vkpuEswO2lxI/jSD/OXe3YCIodkM0
         8i7B3WP6kCE5x7FIBJBFs/7k95GfR+3gXEN23s4pvxnKj7sTXjxQBdIJ3Z1Pheztvj8h
         wFbo/hS3bQZpM0RA8fj+cMDUVSquOmRyAOIqVhtL2FmzU7T4EyQSSwI7UrvK18rsdmuw
         nvBw==
X-Gm-Message-State: AGi0PuZyj2TgYf5LpbiAipd1jmhD3p20yi+/wLecjdVODqOvL1wQovBY
        epqJMI6pRU1RV7wT09I/hHcNRQ==
X-Google-Smtp-Source: APiQypIYdTSZJe3Y4e3+lnSSbtwf1K8offweIlDZGjyZHvtGvqNlYAe+bH5LnVDK5Hv8ivjuh+nPcA==
X-Received: by 2002:a1c:1f0d:: with SMTP id f13mr16463240wmf.184.1589364639220;
        Wed, 13 May 2020 03:10:39 -0700 (PDT)
Received: from [192.168.43.249] (212-39-89-233.ip.btc-net.bg. [212.39.89.233])
        by smtp.googlemail.com with ESMTPSA id m7sm12180941wmc.40.2020.05.13.03.10.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 May 2020 03:10:38 -0700 (PDT)
Subject: Re: [PATCH v8 00/10] Introduce OPP bandwidth bindings
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     vireshk@kernel.org, nm@ti.com, sboyd@kernel.org, rjw@rjwysocki.net,
        saravanak@google.com, sibis@codeaurora.org, mka@chromium.org,
        robh+dt@kernel.org, rnayak@codeaurora.org,
        bjorn.andersson@linaro.org, vincent.guittot@linaro.org,
        jcrouse@codeaurora.org, evgreen@chromium.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200512125327.1868-1-georgi.djakov@linaro.org>
 <20200513065559.wznvqc7tzvmv3ghy@vireshk-i7>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Openpgp: preference=signencrypt
Autocrypt: addr=georgi.djakov@linaro.org; prefer-encrypt=mutual; keydata=
 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
 KEmKjLDvB0pePJkdTw==
Message-ID: <ea73d0e7-7428-c3cf-b44b-59427c4d6109@linaro.org>
Date:   Wed, 13 May 2020 13:10:29 +0300
MIME-Version: 1.0
In-Reply-To: <20200513065559.wznvqc7tzvmv3ghy@vireshk-i7>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Viresh,

On 5/13/20 09:55, Viresh Kumar wrote:
> On 12-05-20, 15:53, Georgi Djakov wrote:
>> Here is a proposal to extend the OPP bindings with bandwidth based on
>> a few previous discussions [1] and patchsets from me [2][3] and Saravana
>> [4][5][6][7][8][9].
>>
>> Changes in v8:
>> * Addressed review comments from Matthias, Sibi and Viresh.
>> * Picked reviewed-by tags.
>> * Picked Sibi's interconnect-tag patches into this patchset.
> 
> I have applied the series with the modifications I replied with
> separately.

Thanks a lot!

> Please lemme know if any more tags (reviewed/acked) etc need to be
> applied or any more changes are required before I send the pull
> request to Rafael.
> 
> Please give my branch a try as soon as you can.

On top of your branch i tested with scaling 3 different test paths (also
tagged with different tags) and it looks good:

 node                                  tag          avg         peak
--------------------------------------------------------------------
slv_ebi_ch0                                      458824      1525000
  cpu0                                   3          922          911
  cpu0                                   2          902          901
  cpu0                                   1       457000      1525000

Apart from that, i ran memory throughput tests and they also confirm
that it's working as expected.

There will be a minor conflict with my branch when this is merged upstream,
so maybe we will need to report it or use an immutable tag/branch.

Thanks,
Georgi
