Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9B7C1EB60A
	for <lists+linux-pm@lfdr.de>; Tue,  2 Jun 2020 08:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725921AbgFBG5Z (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 2 Jun 2020 02:57:25 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:52750 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725897AbgFBG5Z (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 2 Jun 2020 02:57:25 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1591081043; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=gLmQdz2bGLYsw+rnxBnJcFNszpdH/RBI0fmfD79V7/k=;
 b=HCchhsHdZjx7FURvyMH1Du6XtP/8YMA6TdEAhxMo8bBRG1jPZAV4D2jd6iZfQL8m6MCY4tpI
 M9n3yN/q1HMMd3DQ5RTPkjjlwf+5ODbqBTxNohaXECybVZFAOcJ0OCAfl0YKCFWWVRuoHwdj
 Rwd4mAuvAlOQ3mqii8ScPoWTL3U=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n12.prod.us-west-2.postgun.com with SMTP id
 5ed5f8528e09c0ae09d1b3e2 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 02 Jun 2020 06:57:22
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6C1B9C43387; Tue,  2 Jun 2020 06:57:22 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 953F6C433C9;
        Tue,  2 Jun 2020 06:57:20 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 02 Jun 2020 12:27:20 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     sboyd@kernel.org, georgi.djakov@linaro.org, saravanak@google.com,
        mka@chromium.org, nm@ti.com, bjorn.andersson@linaro.org,
        agross@kernel.org, rjw@rjwysocki.net,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dianders@chromium.org,
        vincent.guittot@linaro.org, amit.kucheria@linaro.org,
        lukasz.luba@arm.com, sudeep.holla@arm.com, smasetty@codeaurora.org,
        linux-arm-msm-owner@vger.kernel.org,
        linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH v5 4/5] cpufreq: qcom: Update the bandwidth levels on
 frequency change
In-Reply-To: <20200601110116.jteoalg3yjhsbkpw@vireshk-i7>
References: <20200527202153.11659-1-sibis@codeaurora.org>
 <20200527202153.11659-5-sibis@codeaurora.org>
 <20200529100028.2wz2iqi5vqji2heb@vireshk-i7>
 <a90bce2d52f7cdb726e8b799e3512fad@codeaurora.org>
 <20200601110116.jteoalg3yjhsbkpw@vireshk-i7>
Message-ID: <129d8c6c7099ca49dd465b34a6c5fa34@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On 2020-06-01 16:31, Viresh Kumar wrote:
> On 29-05-20, 17:00, Sibi Sankar wrote:
>> > > +static int qcom_cpufreq_update_opp(struct device *cpu_dev,
>> > > +				   unsigned long freq_khz,
>> > > +				   unsigned long volt)
>> > > +{
>> > > +	unsigned long freq_hz = freq_khz * 1000;
>> > > +
>> > > +	if (dev_pm_opp_adjust_voltage(cpu_dev, freq_hz, volt, volt, volt))
>> > > +		return dev_pm_opp_add(cpu_dev, freq_hz, volt);
>> >
>> > What's going on here ? Why add OPP here ?
>> 
>> We update the voltage if opp were
>> initially added as part of
>> dev_pm_opp_of_add_table. However
>> if the cpu node does not have an
>> opp table associated with it, we
>> do a opp_add_v1 instead.
> 
> Instead of depending on the failure of dev_pm_opp_adjust_voltage(),
> pass a flag to qcom_cpufreq_update_opp() which will decide if we want
> to adjust voltage or add an opp.

Sure will add it in the next
re-spin.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
