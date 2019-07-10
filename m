Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E50D6647E5
	for <lists+linux-pm@lfdr.de>; Wed, 10 Jul 2019 16:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbfGJOOo (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 10 Jul 2019 10:14:44 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:59054 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726458AbfGJOOo (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Jul 2019 10:14:44 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id B4448616BA; Wed, 10 Jul 2019 14:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1562768082;
        bh=tT33zEBA9PtRD/IyowYg4/egpUqKgsUqXRsSxZ2TsDc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PlLcypq+S5CJ+uDTIOt7PtM6y7uf12suXgocabiOn517FPnNl/Ie1GMLbc4PtqJsq
         0STdtJnFsAv1YGvg9DDwJBlwf8/MN+OAGqH0SKQuAKh7cuzd0c/u7e8jc9UJ3lBIQU
         F+3GLfH6X5SJEu/vfQu7MFwDko22xyg0UwpmHjRg=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 5FB4E61157;
        Wed, 10 Jul 2019 14:14:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1562768077;
        bh=tT33zEBA9PtRD/IyowYg4/egpUqKgsUqXRsSxZ2TsDc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=A0fzCeMqOmcCgRGdt06AnbTMN+K+nOl11BW5LXKKOg9nv0wJ4SqKwRNWRWSP8l31I
         WD6h2jkw/gAXKmkKN7LJk+n3dnI/pwXhRA8no7A0PODXrfxo7f2fnWMaXp5LcqfmV9
         t3WOvWrdtZRINX/fROacge/ouizD+RvUGse9pmII=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 10 Jul 2019 19:44:37 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     nm@ti.com, sboyd@kernel.org, georgi.djakov@linaro.org,
        agross@kernel.org, david.brown@linaro.org, robh+dt@kernel.org,
        mark.rutland@arm.com, rjw@rjwysocki.net,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        saravanak@google.com, linux-kernel-owner@vger.kernel.org,
        adharmap@codeaurora.org
Subject: Re: [PATCH RFC 0/4] DDR/L3 Scaling support on SDM845 SoCs
In-Reply-To: <20190701092949.afenn2et2qexostt@vireshk-i7>
References: <20190627133424.4980-1-sibis@codeaurora.org>
 <20190701092949.afenn2et2qexostt@vireshk-i7>
Message-ID: <d2e3b5bf3aa6ee740f004b7b770bef26@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hey Viresh,

On 2019-07-01 14:59, Viresh Kumar wrote:
> On 27-06-19, 19:04, Sibi Sankar wrote:
>> This RFC series aims to extend cpu based scaling support to L3/DDR on
>> SDM845 SoCs. The patch series depends on "Introduce OPP bandwidth 
>> bindings"
>> series (https://patchwork.kernel.org/cover/10912993/). A part of the
>> series will still be applicable if we decide to go ahead with the 
>> proposal
>> from Saravana as well so I decided to post this out.
>> 
>> v2:
>> * Incorporated Viresh's comments from:
>> [1]https://lore.kernel.org/lkml/20190410102429.r6j6brm5kspmqxc3@vireshk-i7/
>> [2]https://lore.kernel.org/lkml/20190410112516.gnh77jcwawvld6et@vireshk-i7/
> 
> Did you get a chance to look at this ?
> 
> lore.kernel.org/lkml/20190622003449.33707-1-saravanak@google.com

Yes, I have v2 of cpufreq passive governor
patch in the works based on Saravana's
series. I plan on posting it out end of
week. I had sent this series out
since a portion (specifically update_
voltage helper and adding opp_tables
to cpufreq-hw driver) would remain
constant irrespective of the path
we choose.

FWIW, on SDM845 SoCs we cannot use a
rpmh_write_batch based icc_set on
cpufreq fast switch pathw since it
uses the "wait_for_completion" api.


-- 
-- Sibi Sankar --
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
