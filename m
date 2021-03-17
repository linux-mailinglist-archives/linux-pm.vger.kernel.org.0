Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6BBC33F297
	for <lists+linux-pm@lfdr.de>; Wed, 17 Mar 2021 15:29:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbhCQO31 (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 17 Mar 2021 10:29:27 -0400
Received: from muru.com ([72.249.23.125]:44138 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231313AbhCQO3Y (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 17 Mar 2021 10:29:24 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 54A0B80BA;
        Wed, 17 Mar 2021 14:30:13 +0000 (UTC)
Date:   Wed, 17 Mar 2021 16:29:19 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com, linux-omap@vger.kernel.org
Subject: Re: [PATCHv2 01/38] ARM: dts: motorola-cpcap-mapphone: Prepare for
 dtbs_check parsing
Message-ID: <YFISPyIMCbp6WcAr@atomide.com>
References: <20210317134904.80737-1-sebastian.reichel@collabora.com>
 <20210317134904.80737-2-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210317134904.80737-2-sebastian.reichel@collabora.com>
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

* Sebastian Reichel <sebastian.reichel@collabora.com> [210317 13:50]:
> '<&gpio1 parameters &gpio2 parameters>' and '<&gpio1 parameters>,
> <&gpio2 parameters>' result in the same DTB, but second format has
> better source code readability. Also 'dtbs_check' currently uses
> this format to determine the amount of items specified, so using
> this syntax is needed to successfully verify the devicetree source
> against a DT schema format.

Looks good to me:

Acked-by: Tony Lindgren <tony@atomide.com>
