Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4382E5FCE54
	for <lists+linux-pm@lfdr.de>; Thu, 13 Oct 2022 00:22:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbiJLWW3 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 12 Oct 2022 18:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiJLWW2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 12 Oct 2022 18:22:28 -0400
Received: from rere.qmqm.pl (rere.qmqm.pl [91.227.64.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B952CAE60
        for <linux-pm@vger.kernel.org>; Wed, 12 Oct 2022 15:22:27 -0700 (PDT)
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 4MnnFq4F5jzBb;
        Thu, 13 Oct 2022 00:22:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1665613344; bh=cQK+1uYjAn1Lrexz8rIq8dhLUrGJHKziIFswEjdQR+k=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=N20Ys88ezUtMyB9eHewqQaJ2w06v+akF8ys7RDMEZsxMIGoGzG5+4F+Zn3mSgYOdK
         2gopKyPpffu6ipCMzeDsqwE2IXQ9xu8WWtk9pR+FYkQ3dGFz8vxQILYpRYNCe/E5uD
         +1RNObeeZ8EMMSJM6hahlJirrsywRduOi5CtTo1PXHkUZi2PjLAUzzt5xx5ROP4U6m
         jvRXSah7qJOy0JH6gx6xhntMhkScV41SazV8jpITqF7e3kcg2A8da+WrvaGbiIEz/G
         eu5XaET0eXGx7BXxegQHlQ4xRx9Kf3nhM2wgC0gsXnBNlivIn5pG1N1l9+4JU3qipL
         IQ6J7X9luHKiw==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.103.7 at mail
Date:   Thu, 13 Oct 2022 00:22:21 +0200
From:   =?iso-8859-2?Q?Micha=B3_Miros=B3aw?= <mirq-linux@rere.qmqm.pl>
To:     Marek Vasut <marex@denx.de>
Cc:     Hans de Goede <hdegoede@redhat.com>, linux-pm@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCH 5/7] power: supply: bq25890: Factor out regulator
 registration code
Message-ID: <Y0c+Had3TTCwl+R1@qmqm.qmqm.pl>
References: <20221010210310.165461-1-marex@denx.de>
 <20221010210310.165461-5-marex@denx.de>
 <e0659fb1-7e1e-de5c-de6a-99a8f180bd3f@redhat.com>
 <00e6b9b0-ddef-6e2f-0603-9a25fd3b9e0d@denx.de>
 <848ada38-00a1-0631-871f-926bb33a166f@redhat.com>
 <021a1dfc-eb05-77ad-644c-f967a5bf7799@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <021a1dfc-eb05-77ad-644c-f967a5bf7799@denx.de>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Thu, Oct 13, 2022 at 12:02:52AM +0200, Marek Vasut wrote:
> On 10/12/22 12:10, Hans de Goede wrote:
[...]
> > Looking at standard Linux userspace (Debian/Fedora/etc.)
> > all the userspace tools capable of reporting voltages
> > of various voltage rails inside the system to the user
> > use the hwmon interface for this. This is also why
> > the power-supply class core recently got support for
> > proxying some psy properties to a hwmon class device.
> > 
> > So the way I see it is that if we want to report Vsys to
> > userspace, that we then clearly need to report it through
> > the hwmon interface.
> 
> For regulators, you can read their values via /sys/class/regulators/* , if
> the user is interesting in Vsys .
> 
> Maybe that is where we disagree -- I'm not particularly interested in
> exposing Vsys to user space, but since it was exposed before, I tried to
> retain that exposure, although via different channel. And the regulator also
> makes the Vsys useful, since it can be used as a supply on the kernel level.

I find knowing Vsys useful at least to have a way to quickly check if
the voltage requirements of other parts of the system are met. I don't
mind regulator vs pure hwmon interface for reading it. Though, a regulator
for Vsys could also include controlling VSYSMIN and BATFET_DIS if anyone
cared to change those at runtime.

Best Regards
Micha³ Miros³aw
