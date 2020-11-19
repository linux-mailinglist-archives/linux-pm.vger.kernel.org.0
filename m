Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBAF02B953F
	for <lists+linux-pm@lfdr.de>; Thu, 19 Nov 2020 15:52:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728384AbgKSOmm (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 19 Nov 2020 09:42:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728366AbgKSOmi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 19 Nov 2020 09:42:38 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF6AC0613D4
        for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2020 06:42:38 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id v144so8530212lfa.13
        for <linux-pm@vger.kernel.org>; Thu, 19 Nov 2020 06:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=pTN/HQEDO++RUgsAeCSdpIeR1pydXC9wuZi7PloDRbw=;
        b=AENo3M1+izNVxpNeDxMVAbzyhkeACQhpUKgIqkmyjm73/Ase0gGZqD69HLnMJeVvkt
         Vn4hpUB9wm9zd0+G8wwl+ieZ1YA40Qbnpd0VuE2gRz5z7lDcFfJalNfA/Br0cpTuk5vO
         98bj6M9i782F+4Xai3TuVskc/IdQ12g8UzUv/Y4wHpUN/HJgeI5RA+/5ZIQF+W9iKvh6
         N6Jrlk0EJUTCTUXwjdkrPnmv5IS3KyRV58AOBJPYhWzoQcVVF3Fvbi1iOA7GejJLahJW
         fSt4gS4SKurn8kqAcatLIcqg/flrK3QAtjatjXrvDdwhRowILFRwjqib9+3ycV6umOxJ
         A4Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=pTN/HQEDO++RUgsAeCSdpIeR1pydXC9wuZi7PloDRbw=;
        b=BdswzB7SoEsyj4yWYobN5abTXaA5tYqUaMyG2JZAxBqC6aGrUY+TAK15MS2pWCH4I+
         DXYc/oatS3C28blueg6oD+9TlHEh+wntbl4Xg8ryLKWpZzty6+KMZ5iKgI2LtFu8NEBy
         ewibHaiawxbWqxt7em+GsbKLOO9CDTqcFCppGL0CGp+Qf8jKfIgY1L11kSbdVc6JBHGK
         GXZSBGCwmiGUTHhvnMmrmEGg/7AGm7xHvlsVPIRSPYWr0zr2kSWBP2PqSQXYtoMjwPSF
         Sb1ySWJBNKbNHKb4jqAH+n+GZLU6Yjsb1OM0mII0XkjUxva73UYsYiF9st1uYP3mx3zm
         tNFQ==
X-Gm-Message-State: AOAM532F3MOp1xjSNcqnJ5bGRGt1OEvaREtVzTEQMnVkLUsR0IHQ56qx
        HRcOd5NWp8nfgVLYTaG3jDXQGQ==
X-Google-Smtp-Source: ABdhPJy+piHovamyM8c9I7UPJdWWCrqCjWV+SbmOQ2WjgJh5YZdBRZn+b9lvKYXwyazvYnuiBCJamA==
X-Received: by 2002:a19:504d:: with SMTP id z13mr5523457lfj.42.1605796956944;
        Thu, 19 Nov 2020 06:42:36 -0800 (PST)
Received: from [192.168.0.150] ([188.162.64.108])
        by smtp.gmail.com with ESMTPSA id j19sm3724875lja.100.2020.11.19.06.42.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2020 06:42:36 -0800 (PST)
Subject: Re: [PATCH v9 00/15] qcom: pm8150: add support for thermal monitoring
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Amit Kucheria <amitk@kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        "open list:DRM DRIVER FOR MSM ADRENO GPU" 
        <linux-arm-msm@vger.kernel.org>, linux-pm@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, linux-iio@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Jishnu Prakash <jprakash@qti.qualcomm.com>
References: <20201102174950.1148498-1-dmitry.baryshkov@linaro.org>
 <c943f56c-f72c-0f14-b6ed-b67e91573b1e@linaro.org>
 <CAA8EJpp+=sQAre+kCiDLEFT+gDB0wO7KypGTXeCDncO8wWzQ-Q@mail.gmail.com>
 <a66e75c1-ce30-df75-c77e-e58e660f0105@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Message-ID: <c14f84ca-cc66-4deb-0583-e2e495ff2233@linaro.org>
Date:   Thu, 19 Nov 2020 17:42:19 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <a66e75c1-ce30-df75-c77e-e58e660f0105@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12/11/2020 16:13, Daniel Lezcano wrote:
> On 12/11/2020 13:41, Dmitry Baryshkov wrote:
>> On Thu, 12 Nov 2020 at 14:39, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>>
>>>
>>> Shall I take patch 1/15 and 12/15 ?
>>
>> 12/15 will not compile without several previous patches, so it might
>> be better to take all of them through the single tree.
> 
> Ok, I will take some time to review the driver and ack it, so it can be
> merged through the iio tree.

Daniel, I'm sorry. Is there any update on this patchset review?


-- 
With best wishes
Dmitry
