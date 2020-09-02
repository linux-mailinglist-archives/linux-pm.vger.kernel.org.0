Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BDE625A6B6
	for <lists+linux-pm@lfdr.de>; Wed,  2 Sep 2020 09:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726800AbgIBH0n (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 2 Sep 2020 03:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbgIBH0m (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 2 Sep 2020 03:26:42 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC380C061245
        for <linux-pm@vger.kernel.org>; Wed,  2 Sep 2020 00:26:41 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id 17so2348806pfw.9
        for <linux-pm@vger.kernel.org>; Wed, 02 Sep 2020 00:26:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=sK/FM/QqHW73s3zW3v2JjJSuecpEd7zSzI7DvlhgvtQ=;
        b=XqtKCU8lMX15QFQGjsxyjexwZtP40XT3gg9pHdjWkBLYqpOqAUiqyaoTAA/4b/UiYA
         hqUUsfjkjxpJrPkI/LDSoFIOynR2ThCRlObFMDYSNq/dDCpP8AzvWQRbbEpP3ffA787F
         0xR5/pdIJD/6H8GsEiMts4Z4bqsubw4rFzV5kQmGEm0q9YoIPmady1TKXYPFi54ikjRb
         pdbbAl0EnhBeo0WN+HRZgIrzEIwdbv0MqGB5EJB+MkNGZxmtZhKiHXK1XaO5xyrmsucY
         rYFCTvtJuduPYWfJrIHm84Ou9znEOkSQ7HGUgMz1XN1c4WOhGPKJrC+w/mdH5PO0QESD
         B4zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sK/FM/QqHW73s3zW3v2JjJSuecpEd7zSzI7DvlhgvtQ=;
        b=qpOXeXR9L7ejUP/1wE60PzSVaHVh1P3MuwMgaoWqnvKz3byOs5Mm+JAEgZ6qgyit20
         uXVHG5kqkVeWtX3VTlrY/mRll9NAtdW+yxr2uuT6hszZ8crWuqhVtrhUDlIKrpb7jvcb
         uqFU6a03XUEx34JDYuxh8x0t29fmhL1nlXjpoZOvUGs+//bBE0wI00c67PcVbwbmKAOx
         5YVLRq1BnB8jA9pI56qUbymLeI9QOKkp07ssl4pxIb2UwXmr4U7oEQx7rc2PBr9Ekarc
         95RB82SXEi8D3V0NIaUsWiRgse/d9QOg2s7FOoTNXpEKNOgQQBr+Oc72l8zSzLuSTdMu
         +hnA==
X-Gm-Message-State: AOAM533JNbBZiKeLsJqVMqUAzhuajyz1I07gUCVzNRc8An5obMjsd/12
        AVRZmqRr0yhCOEICTyyMiN3p6A==
X-Google-Smtp-Source: ABdhPJyVyMe5GyvJB6vhb2TIoerfQydgDh9IXBXNBhHQurkhmi11WCku0J1xI1XV3iAgoQsk7MwdKg==
X-Received: by 2002:a05:6a00:16c2:: with SMTP id l2mr2067448pfc.112.1599031601377;
        Wed, 02 Sep 2020 00:26:41 -0700 (PDT)
Received: from localhost ([122.167.135.199])
        by smtp.gmail.com with ESMTPSA id ih11sm3543286pjb.51.2020.09.02.00.26.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 02 Sep 2020 00:26:40 -0700 (PDT)
Date:   Wed, 2 Sep 2020 12:56:38 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Lukasz Luba <lukasz.luba@arm.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        cristian.marussi@arm.com, rjw@rjwysocki.net
Subject: Re: [PATCH 0/4] CPUFreq statistics retrieved by drivers
Message-ID: <20200902072638.zc352inj236ydgz7@vireshk-i7>
References: <20200729151208.27737-1-lukasz.luba@arm.com>
 <20200730085333.qubrsv7ufqninihd@vireshk-mac-ubuntu>
 <20200730091014.GA13158@bogus>
 <3b3a56e9-29ec-958f-fb3b-c689a9389d2f@arm.com>
 <20200804053502.35d3x3vnb3mggtqs@vireshk-mac-ubuntu>
 <f784bf30-83a6-55ff-8fa6-f7bd2d4399b9@arm.com>
 <20200804103857.mxgkmt6qmmzejuzb@vireshk-mac-ubuntu>
 <1f978078-b2df-a2e5-6af8-e73f65044ba7@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1f978078-b2df-a2e5-6af8-e73f65044ba7@arm.com>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 04-08-20, 11:44, Lukasz Luba wrote:
> On 8/4/20 11:38 AM, Viresh Kumar wrote:
> > I don't think doing it with help of firmware is the right thing to do
> > here then. For another platform we may not have a firmware which can
> > help us, we need something in the opp core itself for that. Lemme see
> > if I can do something about it.
> 
> OK, great, I will wait then with this patch series v2 which would change
> into debugfs scmi only. Could you please add me on CC, I am very
> interested in.

Here is an attempt.

http://lore.kernel.org/lkml/cover.1599031227.git.viresh.kumar@linaro.org

-- 
viresh
