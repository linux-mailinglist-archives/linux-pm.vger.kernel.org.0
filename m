Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD4F6263E8C
	for <lists+linux-pm@lfdr.de>; Thu, 10 Sep 2020 09:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728463AbgIJHXD (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 10 Sep 2020 03:23:03 -0400
Received: from a27-11.smtp-out.us-west-2.amazonses.com ([54.240.27.11]:56820
        "EHLO a27-11.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729993AbgIJHWs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Sep 2020 03:22:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1599722567;
        h=MIME-Version:Content-Type:Content-Transfer-Encoding:Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID;
        bh=FbfkJJzgGeSFmEA1EYRQ444NqK/AGNGzOuF92HpnCDo=;
        b=hwTf+FG96AslNxIvJh/+GN8kQcSvUSqgY1PflN9+EfTonVdl9G76hFVlhFGBgvXj
        JkVMXyAJKAyMbBNFIbm6F3ifVSvG+Druc3q6L/syekGg6PdvDu+gz5N8vn8t18DIJcQ
        rJwIE6uDIn2RcmCkBMjED7SFlGjtQr6gpyQDqVRA=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599722567;
        h=MIME-Version:Content-Type:Content-Transfer-Encoding:Date:From:To:Cc:Subject:In-Reply-To:References:Message-ID:Feedback-ID;
        bh=FbfkJJzgGeSFmEA1EYRQ444NqK/AGNGzOuF92HpnCDo=;
        b=PS0LDCRA1i4lIBm0WJJdB2rjR5af8p8zeRky6ZcuwPdnEYwUTQtHBROrUFWE5FLb
        UePqevIgBRReqw84dTjs5b5hODST/8acMq2wf5zrkbNjbhK7OoZR5mKtLjy2I6wA2Qc
        j7ZmsI2jRnORgHgcukWFMpfykIJsZ0tdUsP4JFpo=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 10 Sep 2020 07:10:47 +0000
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Stephen Boyd <swboyd@chromium.org>
Cc:     khilman@kernel.org, ulf.hansson@linaro.org, rjw@rjwysocki.net,
        agross@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        gregkh@linuxfoundation.org, pavel@ucw.cz, len.brown@intel.com,
        rnayak@codeaurora.org, dianders@chromium.org, mka@chromium.org,
        linux-kernel-owner@vger.kernel.org, clew@codeaurora.org
Subject: Re: [PATCH v2 1/2] PM / Domains: Add GENPD_FLAG_NO_SUSPEND/RESUME
 flags
In-Reply-To: <20200825175345.GC3715@yoga>
References: <20200821204921.32536-1-sibis@codeaurora.org>
 <159804608868.334488.2486130699850456264@swboyd.mtv.corp.google.com>
 <20200824164212.GA3715@yoga>
 <159834001729.334488.11862381163144726708@swboyd.mtv.corp.google.com>
 <20200825175345.GC3715@yoga>
Message-ID: <0101017476da3906-412a2e35-dc56-43ee-8644-83a998279c2d-000000@us-west-2.amazonses.com>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
X-SES-Outgoing: 2020.09.10-54.240.27.11
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2020-08-25 23:23, Bjorn Andersson wrote:
> On Tue 25 Aug 02:20 CDT 2020, Stephen Boyd wrote:
>> Quoting Bjorn Andersson (2020-08-24 09:42:12)
>> > On Fri 21 Aug 14:41 PDT 2020, Stephen Boyd wrote:
> [..]
>> > > I find it odd that this is modeled as a power domain instead of some
>> > > Qualcomm specific message that the remoteproc driver sends to AOSS. Is
>> > > there some sort of benefit the driver gets from using the power domain
>> > > APIs for this vs. using a custom API?
>> >
>> > We need to send "up" and "down" notifications and this needs to happen
>> > at the same time as other standard resources are enabled/disabled.
>> >
>> > Further more, at the time the all resources handled by the downstream
>> > driver was either power-domains (per above understanding) or clocks, so
>> > it made sense to me not to spin up a custom API.
>> >
>> 
>> So the benefit is not spinning up a custom API? I'm not Ulf, but it
>> looks like this is hard to rationalize about as a power domain. It
>> doesn't have any benefit to model it this way besides to make it
>> possible to turn on with other power domains.
>> 
>> This modem remoteproc drivers isn't SoC agnostic anyway, it relies on
>> SMEM APIs, so standing up another small qmp_remoteproc_booted() and
>> qmp_remoteproc_shutdown() API would avoid adding a genpd flag here 
>> that
>> probably will never be used outside of this corner-case. There is also
>> some get/put EPROBE_DEFER sort of logic to implement, but otherwise it
>> would be possible to do this outside of power domains, and that seems
>> better given that this isn't really a power domain to start with.
> 
> In later platforms a few new users of the AOSS communication interface
> is introduced that certainly doesn't fit any existing API/framework in
> the kernel. So the plan was to pretty much expose qmp_send() to these
> drivers.
> 
> My worry with using this interface is that we'll probably have to come
> up with some DT binding pieces and probably we'll end up adding yet
> another piece of hard coded information in the remoteproc drivers.
> 
> But I'm not against us doing this work in favor of not having to
> introduce a one-off for this corner case.

Bjorn/Stephen,

So the consensus is to stop modelling
aoss load_state as pds and expose qmp_send
to drivers?

> 
> Regards,
> Bjorn




-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
