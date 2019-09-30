Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9DFC2066
	for <lists+linux-pm@lfdr.de>; Mon, 30 Sep 2019 14:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729415AbfI3MOu (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 30 Sep 2019 08:14:50 -0400
Received: from vps0.lunn.ch ([185.16.172.187]:54000 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726008AbfI3MOu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 30 Sep 2019 08:14:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Cs6i4ZwAF8VZe/f+tj45Qc3PscNqg2hbvI0kGS3P7PM=; b=MfSjHOwjRy+ci3bxERgM3msN6W
        qcF7r3DjwzQNbpjcqDc8lq8ATtsZSAwFrIqynBF36pdORLYDeqeDvn9qvFLb0T7D4ODUAxl8nS8F/
        bKJpijEbsGzisLv9154HzRgqsuHldOnlF54DBQm/INrj0QkSF5tEotzkdWpVqhLFs9YU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.92.2)
        (envelope-from <andrew@lunn.ch>)
        id 1iEuZc-0003YY-Mo; Mon, 30 Sep 2019 14:14:40 +0200
Date:   Mon, 30 Sep 2019 14:14:40 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Jamie Lentin <jm@lentin.co.uk>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        Igor Opaniuk <igor.opaniuk@toradex.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 0/2] This patch introduces a feature to force
 gpio-poweroff module
Message-ID: <20190930121440.GC13301@lunn.ch>
References: <20190930103531.13764-1-oleksandr.suvorov@toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190930103531.13764-1-oleksandr.suvorov@toradex.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Sep 30, 2019 at 10:35:36AM +0000, Oleksandr Suvorov wrote:
> to register its own pm_power_off handler even if someone has registered
> this handler earlier.
> Useful to change a way to power off the system using DT files.

Hi Oleksandr

I'm not sure this is a good idea. What happens when there are two
drivers using forced mode? You then get which ever is register last.
Non deterministic behaviour.

What is the other driver which is causing you problems? How is it
getting probed? DT?

Thanks
	Andrew
