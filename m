Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1553631AB43
	for <lists+linux-pm@lfdr.de>; Sat, 13 Feb 2021 13:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbhBMMSQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sat, 13 Feb 2021 07:18:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:49710 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229574AbhBMMSO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 13 Feb 2021 07:18:14 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id A58F764DA8;
        Sat, 13 Feb 2021 12:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1613218654;
        bh=/VPwgG/zMLjzBWAILjPVcvxFtC+Q/7ezOYp/x+YjNl0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Cc+5P3Ep4YuuhjYjflDa1stF9orp+PTvogl5p746Zm3PVI965pwcqXtdDtDwEW+ZW
         yRCnpX0eYZdsUC57+51MYPNCAadsCDZ2wocU5YhSYiI7Hd2P6C2PvkduRd/D8nKzQz
         EjSk+L7Z6wh3XLjWORPvUr4qRtVWJj5th7J3EXdg=
Date:   Sat, 13 Feb 2021 13:17:30 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     mazziesaccount@gmail.com, "Rafael J. Wysocki" <rafael@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Jean Delvare <jdelvare@suse.com>,
        Mark Gross <mgross@linux.intel.com>,
        Sebastian Reichel <sre@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Saravana Kannan <saravanak@google.com>,
        Joerg Roedel <jroedel@suse.de>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [RFC PATCH 5/7] power: supply: Clean-up few drivers by using
 managed work init
Message-ID: <YCfDWmAZlAHkvuwT@kroah.com>
References: <cover.1613216412.git.matti.vaittinen@fi.rohmeurope.com>
 <a3ca401194012d75725049839a1c210d313f0595.1613216412.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3ca401194012d75725049839a1c210d313f0595.1613216412.git.matti.vaittinen@fi.rohmeurope.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sat, Feb 13, 2021 at 02:12:41PM +0200, Matti Vaittinen wrote:
> Few drivers implement remove call-back only for ensuring a delayed
> work gets cancelled prior driver removal. Clean-up these by switching
> to use devm_delayed_work_autocancel() instead.
> 
> This change is compile-tested only. All testing is appreciated.

These will all break as I mentioned before...

