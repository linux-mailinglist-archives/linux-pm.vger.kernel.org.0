Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3A65FC087
	for <lists+linux-pm@lfdr.de>; Wed, 12 Oct 2022 08:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiJLGUF (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Oct 2022 02:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiJLGUE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Oct 2022 02:20:04 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A6414B0CC
        for <linux-pm@vger.kernel.org>; Tue, 11 Oct 2022 23:20:02 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id y1so8463604pfr.3
        for <linux-pm@vger.kernel.org>; Tue, 11 Oct 2022 23:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=L1DBCnqUWhGB+br9qPogkPCpewlTh7l7APNpyuPMgnc=;
        b=tSIgrK9R8quYMlKPHoAR2TiQYQinwSPupSlTrpqcDazc8Djrf8h+J8uy1Deju1sRaP
         HUIm8v1EDo2lEXoCQcin34U8dIBoxU+u0FKqHjuxw2fdwcnIeZtjDOSALN/WKjEsg9YX
         OPkMPS3zp5hOn9jjmlix4NRhEiI+2pCUQyPUzTlUy4ePKW62SaVqcyy0HuOWSPHJUgej
         3l51Lo1Y4HrKmkmCmLsl1Zy1MKYOTIWH2L0tRtdQzzbbd2RncC/DsSrMWre8h+1zNYnK
         6ha9w41B98s3rVRxHaS8ap4k5Ll8e9eTtdi9nVq6OfP1gBh8cbwlMedwQom2L0UjE6fO
         84iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L1DBCnqUWhGB+br9qPogkPCpewlTh7l7APNpyuPMgnc=;
        b=Z0eWgG2wMntZRuolOfDUODbaQtx/vsx0QL0g+BErQP5Ng4+pnjl/sXyf/gd8XhMczN
         +zJD/XNI/Rhoo6/DYI1cNv5KGgmN1Id2WxDRpqb5CAvnEDb5cw8s1IQN3iH9lgJ9BVut
         pGUvBVihrybWGyHljffqtB6qH43OkHNLUQf4G+tH1R5+yUH18uYB/cxThmk+EOxACl0p
         12ncCkXsCcOxlb0jDNUKC0Hjp+c2Vl6h0AO4852ctBa4xTudP82jisbxZygd5V0k5mWp
         7zg8aBWYc768UqO1VTq/NNdQrqhxfFjnNbsjTySoCjG6vIBJ0MS5CaxE5g6OdXlx7orw
         rlXw==
X-Gm-Message-State: ACrzQf0vSQeLZUFbib+Fah8Nn4MMMiZMRkRpp+RZQSKkbCN30rNbb2q5
        1fAfZzu/INuZh3dlnRNLz11jQA==
X-Google-Smtp-Source: AMsMyM5d4J4J3Gk4lp+FLUDAe2grvtFcBiQy+UBxS3dMKP5NY726GPrMuMnikSc3GVmxYo5eEh3cCg==
X-Received: by 2002:a05:6a00:1956:b0:557:7f97:3ff3 with SMTP id s22-20020a056a00195600b005577f973ff3mr29340817pfk.77.1665555601674;
        Tue, 11 Oct 2022 23:20:01 -0700 (PDT)
Received: from localhost ([122.172.86.128])
        by smtp.gmail.com with ESMTPSA id x3-20020a1709029a4300b0016d773aae60sm9696338plv.19.2022.10.11.23.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 23:20:00 -0700 (PDT)
Date:   Wed, 12 Oct 2022 11:49:58 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     =?utf-8?B?5rSq5oiQ5paHKEtldmVuKQ==?= <hongchengwen@oppo.com>
Cc:     "rafael@kernel.org" <rafael@kernel.org>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        =?utf-8?B?6ZmI5b6B6byO?= <chenzhengding@oppo.com>
Subject: Re: =?utf-8?B?5Zue5aSNOiBbUEFUQ0hdIEFORFJPSUQ=?= =?utf-8?Q?=3A?=
 cpufreq: times: record fast switch frequency transitions
Message-ID: <20221012061958.xoio4xt3kywpjyf3@vireshk-i7>
References: <1665231397-115755-1-git-send-email-hongchengwen@oppo.com>
 <20221010063235.3zb6bgtxwpmltlrk@vireshk-i7>
 <HK0PR02MB3379062A9BE6515D1DADB306A0229@HK0PR02MB3379.apcprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <HK0PR02MB3379062A9BE6515D1DADB306A0229@HK0PR02MB3379.apcprd02.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 12-10-22, 06:17, 洪成文(Keven) wrote:
> Viresh Kumar
> 
> This is a modification based on the Linux kernel, not an Android version.
> You may have misunderstood some fields in the commit message.

Linux doesn't have cpufreq_times_record_transition().

-- 
viresh
