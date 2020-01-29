Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD3B514CB8F
	for <lists+linux-pm@lfdr.de>; Wed, 29 Jan 2020 14:40:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726145AbgA2Nku (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 29 Jan 2020 08:40:50 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:19259 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726140AbgA2Nku (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Jan 2020 08:40:50 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1580305249; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=PoWTIy25MBRVH614oMB4jheRLUxE3/mTK/UJrdORApY=;
 b=fbDlU/yRvEJA833E+6KiHh9PGOVJwdpJ7fDHvNfWI5hY5bihEvN2Wx2RluY/7MJTesNxodcn
 Ck42uRrAt6J4ENhinUZXpHTDrGLVJGCNW1n+rQOD91lX7hfR3vlVuY5dc9K71KpQ1kYB2gSc
 RBOwztKa/ad7PKlexuHWgO3IjqU=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e318b60.7eff2a24f228-smtp-out-n02;
 Wed, 29 Jan 2020 13:40:48 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7C80CC4479F; Wed, 29 Jan 2020 13:40:46 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 144A0C43383;
        Wed, 29 Jan 2020 13:40:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 29 Jan 2020 19:10:45 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Saravana Kannan <saravanak@google.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Sweeney, Sean" <seansw@qti.qualcomm.com>,
        David Dai <daidavid1@codeaurora.org>, adharmap@codeaurora.org,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Android Kernel Team <kernel-team@android.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 2/3] OPP: Add support for bandwidth OPP tables
In-Reply-To: <CAGETcx9Or==EEL6jRMEh4bG4cmFmLqk_n1ReKT=cg-MEsL9w0w@mail.gmail.com>
References: <20191207002424.201796-1-saravanak@google.com>
 <20191207002424.201796-3-saravanak@google.com>
 <c701fe1d94631e3aba92a8c80070c6a4@codeaurora.org>
 <CAGETcx9Or==EEL6jRMEh4bG4cmFmLqk_n1ReKT=cg-MEsL9w0w@mail.gmail.com>
Message-ID: <6ff35ef93af365c6bc457987c1f92eba@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hey Saravana,

On 2020-01-08 11:46, Saravana Kannan wrote:
> On Tue, Jan 7, 2020 at 11:28 AM Sibi Sankar <sibis@codeaurora.org> 
> wrote:
>> 
>> Hey Saravana,
>> 
>> Spent some time testing this series while
>> trying out dcvs on SDM845/SC7180. Apart from
>> the few minor issues it works quite well!
> 
> Thanks a lot for testing Sibi. Can you give a tested-by? Glad to hear
> it works well.

sry missed this mail. Sure will
add Tested-by in the next revision.

> 
>> On 2019-12-07 05:54, Saravana Kannan wrote:
>> > Not all devices quantify their performance points in terms of
>> > frequency.
>> > Devices like interconnects quantify their performance points in terms
>> > of
>> > bandwidth. We need a way to represent these bandwidth levels in OPP.
>> > So,
>> > add support for parsing bandwidth OPPs from DT.
>> >
>> > Signed-off-by: Saravana Kannan <saravanak@google.com>
>> > ---
>> >  drivers/opp/core.c | 15 +++++++++--
>> >  drivers/opp/of.c   | 63 ++++++++++++++++++++++++++++++++--------------
>> >  drivers/opp/opp.h  |  5 ++++
>> >  3 files changed, 62 insertions(+), 21 deletions(-)
>> >
>> > diff --git a/drivers/opp/core.c b/drivers/opp/core.c
>> > index be7a7d332332..c79bbfac7289 100644
>> > --- a/drivers/opp/core.c
>> > +++ b/drivers/opp/core.c
>> > @@ -1282,11 +1282,21 @@ static bool
>> > _opp_supported_by_regulators(struct dev_pm_opp *opp,
>> >       return true;
>> >  }
>> >
>> > +int opp_compare_key(struct dev_pm_opp *opp1, struct dev_pm_opp *opp2)
>> > +{
>> > +     if (opp1->rate != opp2->rate)
>> > +             return opp1->rate < opp2->rate ? -1 : 1;
>> > +     if (opp1->peak_bw != opp2->peak_bw)
>> > +             return opp1->peak_bw < opp2->peak_bw ? -1 : 1;
>> > +     return 0;
>> > +}
>> > +
>> >  static int _opp_is_duplicate(struct device *dev, struct dev_pm_opp
>> > *new_opp,
>> >                            struct opp_table *opp_table,
>> >                            struct list_head **head)
>> >  {
>> >       struct dev_pm_opp *opp;
>> > +     int opp_cmp;
>> >
>> >       /*
>> >        * Insert new OPP in order of increasing frequency and discard if
>> > @@ -1297,12 +1307,13 @@ static int _opp_is_duplicate(struct device
>> > *dev, struct dev_pm_opp *new_opp,
>> >        * loop.
>> >        */
>> >       list_for_each_entry(opp, &opp_table->opp_list, node) {
>> > -             if (new_opp->rate > opp->rate) {
>> > +             opp_cmp = opp_compare_key(new_opp, opp);
>> > +             if (opp_cmp > 0) {
>> >                       *head = &opp->node;
>> >                       continue;
>> >               }
>> >
>> > -             if (new_opp->rate < opp->rate)
>> > +             if (opp_cmp < 0)
>> >                       return 0;
>> >
>> >               /* Duplicate OPPs */
>> > diff --git a/drivers/opp/of.c b/drivers/opp/of.c
>> > index 1cbb58240b80..b565da5a2b1f 100644
>> > --- a/drivers/opp/of.c
>> > +++ b/drivers/opp/of.c
>> > @@ -521,6 +521,44 @@ void dev_pm_opp_of_remove_table(struct device
>> > *dev)
>> >  }
>> >  EXPORT_SYMBOL_GPL(dev_pm_opp_of_remove_table);
>> >
>> > +static int _read_opp_key(struct dev_pm_opp *new_opp, struct
>> > device_node *np,
>> > +                      bool *rate_not_available)
>> > +{
>> > +     int ret;
>> > +     u64 rate;
>> > +     u32 bw;
>> > +
>> > +     ret = of_property_read_u64(np, "opp-hz", &rate);
>> > +     if (!ret) {
>> > +             /*
>> > +              * Rate is defined as an unsigned long in clk API, and so
>> > +              * casting explicitly to its type. Must be fixed once rate is 64
>> > +              * bit guaranteed in clk API.
>> > +              */
>> > +             new_opp->rate = (unsigned long)rate;
>> > +             goto out;
>> > +     }
>> > +
>> > +     ret = of_property_read_u32(np, "opp-peak-kBps", &bw);
>> > +     if (!ret) {
>> > +             new_opp->peak_bw = bw;
>> > +
>> > +             if (!of_property_read_u32(np, "opp-avg-kBps", &bw))
>> > +                     new_opp->avg_bw = bw;
>> > +     }
>> > +
>> > +out:
>> > +     *rate_not_available = !!ret;
>> > +     /*
>> > +      * If ret is 0 at this point, we have already found a key. If we
>> > +      * haven't found a key yet, then ret already has an error value. In
>> > +      * either case, we don't need to update ret.
>> > +      */
>> > +     of_property_read_u32(np, "opp-level", &new_opp->level);
>> > +
>> > +     return ret;
>> > +}
>> > +
>> >  /**
>> >   * _opp_add_static_v2() - Allocate static OPPs (As per 'v2' DT
>> > bindings)
>> >   * @opp_table:       OPP table
>> > @@ -558,26 +596,12 @@ static struct dev_pm_opp
>> > *_opp_add_static_v2(struct opp_table *opp_table,
>> >       if (!new_opp)
>> >               return ERR_PTR(-ENOMEM);
>> >
>> > -     ret = of_property_read_u64(np, "opp-hz", &rate);
>> > -     if (ret < 0) {
>> > -             /* "opp-hz" is optional for devices like power domains. */
>> > -             if (!opp_table->is_genpd) {
>> > -                     dev_err(dev, "%s: opp-hz not found\n", __func__);
>> > -                     goto free_opp;
>> > -             }
>> > -
>> > -             rate_not_available = true;
>> > -     } else {
>> > -             /*
>> > -              * Rate is defined as an unsigned long in clk API, and so
>> > -              * casting explicitly to its type. Must be fixed once rate is 64
>> > -              * bit guaranteed in clk API.
>> > -              */
>> > -             new_opp->rate = (unsigned long)rate;
>> > +     ret = _read_opp_key(new_opp, np, &rate_not_available);
>> > +     if (ret) {
>> 
>> if (!opp_table->is_genpd) {
>> 
>> _read_opp_key returns an error for genpd
>> opps so please check if it is a genpd
>> opp_table before erroring out here.
> 
> Thanks. I'll fix it in the next version.
> 
>> > +             dev_err(dev, "%s: opp key field not found\n", __func__);
>> > +             goto free_opp;
>> >       }
>> >
>> > -     of_property_read_u32(np, "opp-level", &new_opp->level);
>> > -
>> >       /* Check if the OPP supports hardware's hierarchy of versions or not
>> > */
>> >       if (!_opp_is_supported(dev, opp_table, np)) {
>> >               dev_dbg(dev, "OPP not supported by hardware: %llu\n", rate);
>> > @@ -616,7 +640,8 @@ static struct dev_pm_opp
>> > *_opp_add_static_v2(struct opp_table *opp_table,
>> >       if (of_property_read_bool(np, "opp-suspend")) {
>> >               if (opp_table->suspend_opp) {
>> >                       /* Pick the OPP with higher rate as suspend OPP */
>> > -                     if (new_opp->rate > opp_table->suspend_opp->rate) {
>> > +                     if (opp_compare_key(new_opp,
>> > +                                         opp_table->suspend_opp) > 1) {
>> 
>> shouldn't the condition be > 0?
> 
> Duh. Thanks. I'll fix it in the next version.
> 
> I'm guessing you tested with the fixes you pointed out?

yes

> 
> -Saravana

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
