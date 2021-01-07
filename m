Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E1182ECE77
	for <lists+linux-pm@lfdr.de>; Thu,  7 Jan 2021 12:14:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725974AbhAGLM4 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 7 Jan 2021 06:12:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725965AbhAGLM4 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 Jan 2021 06:12:56 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5FEBC0612F9
        for <linux-pm@vger.kernel.org>; Thu,  7 Jan 2021 03:12:15 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id v14so4838817wml.1
        for <linux-pm@vger.kernel.org>; Thu, 07 Jan 2021 03:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=to:cc:references:from:subject:message-id:date:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=ZynQhWe3fd8d3rbeFrZK14vZrDatqdzqZsjiGQ+4gMY=;
        b=LxY/ejdwoSoObjunALR5FJi4o2lBFvNx6PB9iJd4QfwxSGDxKW8Ff6hsqG9zuMW7CJ
         O9ppdSJg/zF5lvT7ff4jHtYds/qH5EOj1hrXBoWpnY389wn05hiFcdleQwZBTfmEvPa2
         vUC1wrl0g9YR4CTs7DUR4R57+ZNFLcTN148INc3fEKS/9Em6+8Xph8iCJ1p7mq59LmA+
         LnGUEm3r8cxN4+YDlkIN44ml6tW/AK0E0emDw4DwS9U61hQzzJFj7my41XYARwasNTt4
         Z4y6FW3u1W0G+ehOqpSy0eV+//kYlumrbtJA8cq45JYCKs30vG3k7hz5eOHBGG5BWbDn
         5oBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:references:from:subject:message-id:date
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ZynQhWe3fd8d3rbeFrZK14vZrDatqdzqZsjiGQ+4gMY=;
        b=Oeka+LfC4FQTlaarhCfSTOCCP9ZruBb4ESUCkPtuoXLa6dARj9tplduhksDA3wTxjs
         5SMrRwlX9gnecdvsJ4RRttq0SEhd196rB6WvIc0OvQpdVuTwMuuCg/435c/xrXcb7LoH
         vAJ+2x6+LwGyZ5VNumEbeNeto4h2EVARP6hsMuQsuDVUEjJnMbk8s/zhEDPU/qMKnu8B
         hwKQROPISs1eHJnpXSIVdpjOSI+VWU6t48tLvMKRxcNC/ENNsrRKfbwZWEHxJi3CT3iI
         VeIZujNkJXBeHm0jIyoGCEOLY0SzqYlFRJ/eDosPvMwyuGlB4mz+5we4QsGeIb6JILdd
         mN+w==
X-Gm-Message-State: AOAM531uwAOlTpHzDjpviqlDOS0wP/gj79GZxeuqzVdtdk4YX+a5hYas
        13Mphrj0gyUjSchRxXwG1U7h8w==
X-Google-Smtp-Source: ABdhPJxwyVRFJZcoRmxY2+1T3897m+Xju5UWIneY85jpnD9vA6wNVGPJBzhu9M+arSqzN2sNax6QCw==
X-Received: by 2002:a7b:c319:: with SMTP id k25mr7686981wmj.142.1610017932780;
        Thu, 07 Jan 2021 03:12:12 -0800 (PST)
Received: from [10.44.66.8] ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id a62sm8042195wmh.40.2021.01.07.03.12.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jan 2021 03:12:12 -0800 (PST)
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210106094723.563-1-georgi.djakov@linaro.org>
 <X/X5euQ0xgzVv/0R@kroah.com>
From:   Georgi Djakov <georgi.djakov@linaro.org>
Subject: Re: [GIT PULL] interconnect fixes for 5.11-rc
Message-ID: <16762fad-e814-6f74-333e-71676aa4b90d@linaro.org>
Date:   Thu, 7 Jan 2021 13:12:14 +0200
MIME-Version: 1.0
In-Reply-To: <X/X5euQ0xgzVv/0R@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 1/6/21 19:55, Greg KH wrote:
> On Wed, Jan 06, 2021 at 11:47:23AM +0200, Georgi Djakov wrote:
>> Hello Greg,
>>
>> Here is a pull request with a few interconnect fixes for 5.11-rc.
>> More details are available in the signed tag. Please take them into
>> char-misc-linus when possible. The patches have been in linux-next
>> during the last few days.
>>
>> Thanks,
>> Georgi
>>
>> The following changes since commit 5c8fe583cce542aa0b84adc939ce85293de36e5e:
>>
>>    Linux 5.11-rc1 (2020-12-27 15:30:22 -0800)
>>
>> are available in the Git repository at:
>>
>>    git://git.kernel.org/pub/scm/linux/kernel/git/djakov/icc.git tags/icc-5.11-rc3
> 
> Pulled and pushed out, thanks.
> 
Hi Greg,

I still don't see this in your tree, so just checking whether i need to fix 
something or some script is stuck? Or maybe I just need to be more patient,
since you haven't had a chance to push yet.

Thanks!
Georgi
