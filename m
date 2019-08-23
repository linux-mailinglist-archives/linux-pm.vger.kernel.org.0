Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B5549A7CF
	for <lists+linux-pm@lfdr.de>; Fri, 23 Aug 2019 08:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389682AbfHWGve (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 23 Aug 2019 02:51:34 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48900 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732321AbfHWGvd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 23 Aug 2019 02:51:33 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5ABF960E57; Fri, 23 Aug 2019 06:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566543093;
        bh=kv6YyZbAfmhHH6lQEwMxYC8DafkWAPVqggKZIIaBG4g=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=GQYgNsrDoRfA3PN/q1STftgH5y8ba6EdQ59XbiSSsb5/eX0mUbgnX6fGs2eiGfX9n
         2PFg7M12Og+FM/Cgj1bESUfI74FARFqqf+sTlY5SZvJecf1nUoOXZ0bMXNDiJQfAwL
         rM6ZpkcWlG0rC+kVhVGTmjnub2GDjdTijaSL/cLw=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from [10.242.6.109] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mkshah@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 877C0605A5;
        Fri, 23 Aug 2019 06:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1566543092;
        bh=kv6YyZbAfmhHH6lQEwMxYC8DafkWAPVqggKZIIaBG4g=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=NQR8OpyX+5dTGRSWj9jGppAWqlKEMya+KKsr5IypewBq8DCQ2cS0eCbMA8Qu7CsKe
         /tcFDNwkqdg1rrt0xEP7yfrioU40YSNL9dqlG1lTOB5JXJOnMRN/i/b5uXksTwPPQI
         jDHvuQe19pJqy9oBOr/TSip2+MR6ryV3+bdny4AY=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 877C0605A5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mkshah@codeaurora.org
Subject: Re: [PATCH 0/4] Add RSC power domain support
To:     Stephen Boyd <swboyd@chromium.org>, agross@kernel.org,
        david.brown@linaro.org, linux-arm-msm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        bjorn.andersson@linaro.org, evgreen@chromium.org,
        dianders@chromium.org, rnayak@codeaurora.org, ilina@codeaurora.org,
        lsrao@codeaurora.org, ulf.hansson@linaro.org
References: <20190813082442.25796-1-mkshah@codeaurora.org>
 <5d5450b2.1c69fb81.ec1c1.1cb2@mx.google.com>
From:   Maulik Shah <mkshah@codeaurora.org>
Message-ID: <def5e325-c797-b13e-1ea3-3664394a5896@codeaurora.org>
Date:   Fri, 23 Aug 2019 12:21:26 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <5d5450b2.1c69fb81.ec1c1.1cb2@mx.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


On 8/14/2019 11:49 PM, Stephen Boyd wrote:
> Quoting Maulik Shah (2019-08-13 01:24:38)
>> Resource State Coordinator (RSC) is responsible for powering off/lowering
>> the requirements from CPU subsystem for the associated hardware like buses,
>> clocks, and regulators when all CPUs and cluster is powered down.
>>
>> RSC power domain uses last-man activities provided by genpd framework based on
>> Ulf Hansoon's patch series[1], when the cluster of CPUs enter deepest idle
>> states. As a part of domain poweroff, RSC can lower resource state requirements
>> by flushing the cached sleep and wake state votes for resources.
> This series looks like half the solution. Is there a full set of patches
> that connects the RPMh power domain to cpuidle and genpds?
Yes, i will include in next version.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

