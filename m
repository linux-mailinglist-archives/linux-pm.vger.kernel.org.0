Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53837A49D4
	for <lists+linux-pm@lfdr.de>; Sun,  1 Sep 2019 16:30:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728687AbfIAOa2 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 1 Sep 2019 10:30:28 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:57592 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728673AbfIAOa2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 1 Sep 2019 10:30:28 -0400
X-Greylist: delayed 432 seconds by postgrey-1.27 at vger.kernel.org; Sun, 01 Sep 2019 10:30:26 EDT
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl-tcp.brodo.linta [10.1.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 0BE2B2006D6;
        Sun,  1 Sep 2019 14:23:13 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id 4981F80774; Sun,  1 Sep 2019 16:23:04 +0200 (CEST)
Date:   Sun, 1 Sep 2019 16:23:04 +0200
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     Akinobu Mita <akinobu.mita@gmail.com>
Cc:     linux-leds@vger.kernel.org, linux-pm@vger.kernel.org,
        Alan Stern <stern@rowland.harvard.edu>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/2] PM-runtime: Documentation: add runtime_status ABI
 document
Message-ID: <20190901142304.GA20868@owl.dominikbrodowski.net>
References: <1567346932-16744-1-git-send-email-akinobu.mita@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1567346932-16744-1-git-send-email-akinobu.mita@gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi!

On Sun, Sep 01, 2019 at 11:08:51PM +0900, Akinobu Mita wrote:
> +What:		/sys/devices/.../power/runtime_status
> +Date:		April 2010
> +Contact:	Dominik Brodowski <linux@dominikbrodowski.net>

Thanks for the patch! I am not sure, however, whether I am the right contact
person here -- maybe Rafael J. Wysocki as PM maintainer?

Thanks,
	Dominik
