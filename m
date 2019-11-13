Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A94A6FB13C
	for <lists+linux-pm@lfdr.de>; Wed, 13 Nov 2019 14:24:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbfKMNYX (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 13 Nov 2019 08:24:23 -0500
Received: from mail-ed1-f68.google.com ([209.85.208.68]:35082 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbfKMNYW (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 13 Nov 2019 08:24:22 -0500
Received: by mail-ed1-f68.google.com with SMTP id r16so1813278edq.2
        for <linux-pm@vger.kernel.org>; Wed, 13 Nov 2019 05:24:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:openpgp:message-id:date:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=JRP/6EKOcSy60KLVoWb7jM1Tf5lS/OPVbKzG0KgZCIY=;
        b=uAo9yOmMnM/3SrNHSnXryuXkoyxb7GED2KW+gIH19apn94zis9+gv/nx8PglsR6vpz
         qgtdeMAI+ooZ7/giFoQgpO9y5Lk6VE/AHCfSm/vZLHdwBv3H8neAZyQ9j9WyTEHri1Xa
         lJieaXHz3a86aDe6YDxtgc/RLaADka6P+E/kyDkiaBWNprpijul2teXVwERnh1LlT7pu
         roagxEM8zv0CKc08CIY7j5Cs6C7GbzXyRZRYcCm5++1/44kHTBy8c/SL2b6YN6AiyeVL
         m6zBIp5Yl0jCmcqa1K9N2gaDZWAPTq1WfzDTgAhUMawRzqwg8IJ1qNETtKIncMHKfqrM
         PGMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JRP/6EKOcSy60KLVoWb7jM1Tf5lS/OPVbKzG0KgZCIY=;
        b=Ywhk6sA3S09aDtcfSmv3f9n/WmI2T/3t1Xu0ZTkZBQEe0oV9ZG6RpAjdcVkafM/iSe
         AO3iUDCI9Kk54BEDJcfI/7oT5PEirweoI1AQxWK5yXwo+EjtwtrOU+jW1+U47L31514O
         Y37vBvSONimvry6JDTWLHTHFSwBIHodLMHLLs+kNVf+mmu757Ryxf46o1rKd7dGPbdJ5
         b5Hb+a1ptRz/6vw/5AfLR2NyuRWo09dphFID8PVfFUMOqjn5mzJoUuIAbnX/bgtgT/wq
         0eAkra33Cue/FNktg9y/UySiKH1f62wbUkjL/h+ctGzO16jYfJXtakAkUFVzsf5XFuIU
         9Myg==
X-Gm-Message-State: APjAAAUNxbIdk6rE0rb0d87IXI1hFLM8iTUm2RHfSJiANSFxaw48Opxc
        ti+ps+dmgHwjixjGPX31Kx4SjQ==
X-Google-Smtp-Source: APXvYqxeIzEC0kKghBW/pPOmDCzIOyjj19Pwibt4u2DqsePBx8gRya4BnBeKHlC6mxU0yG1bCUmjRw==
X-Received: by 2002:a17:906:c797:: with SMTP id cw23mr2705388ejb.19.1573651461073;
        Wed, 13 Nov 2019 05:24:21 -0800 (PST)
Received: from [192.168.27.135] ([37.157.136.206])
        by smtp.googlemail.com with ESMTPSA id r12sm245953edm.85.2019.11.13.05.24.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Nov 2019 05:24:20 -0800 (PST)
Subject: Re: [PATCH v10 2/3] interconnect: qcom: Add MSM8916 interconnect
 provider driver
To:     Dmitry Osipenko <digetx@gmail.com>, robh+dt@kernel.org,
        linux-pm@vger.kernel.org
Cc:     agross@kernel.org, bjorn.andersson@linaro.org,
        evgreen@chromium.org, daidavid1@codeaurora.org,
        vincent.guittot@linaro.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20191030153904.8715-1-georgi.djakov@linaro.org>
 <20191030153904.8715-3-georgi.djakov@linaro.org>
 <88315b5a-1354-acf9-d57d-b301fb78cfa4@gmail.com>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <95eb0a55-d36b-b66e-ae64-18aa5baafff7@linaro.org>
Date:   Wed, 13 Nov 2019 15:24:19 +0200
MIME-Version: 1.0
In-Reply-To: <88315b5a-1354-acf9-d57d-b301fb78cfa4@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Dmitry,

On 13.11.19 г. 15:03 ч., Dmitry Osipenko wrote:
> 30.10.2019 18:39, Georgi Djakov пишет:
>> Add driver for the Qualcomm interconnect buses found in MSM8916 based
>> platforms. The topology consists of three NoCs that are controlled by
>> a remote processor that collects the aggregated bandwidth for each
>> master-slave pairs.
>>
[..]
>> +static int qnoc_remove(struct platform_device *pdev)
>> +{
>> +	struct qcom_icc_provider *qp = platform_get_drvdata(pdev);
>> +	struct icc_provider *provider = &qp->provider;
>> +	struct icc_node *n;
>> +
>> +	list_for_each_entry(n, &provider->nodes, node_list) {
>> +		icc_node_del(n);
>> +		icc_node_destroy(n->id);
>> +	}
> 
> Hello Georgi,
> 
> While examining the interconnect API and current drivers' code, I
> noticed that everybody are copying this chunk of code which should crash
> kernel because removing node from a list during the traverse is allowed
> only when list_for_each_entry_safe() is used.

Nice catch. Thank you!

> Seems the IMX driver (which is under review now on the ML) is the only
> driver that does the removing procedure correctly.
> 
> Maybe it won't hurt to factor out the removal of provider's nodes into a
> common helper.
> 

Yes, this is a very good idea. Will do it.

Thanks,
Georgi
