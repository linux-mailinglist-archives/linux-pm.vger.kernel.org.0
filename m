Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 96E7F1D526C
	for <lists+linux-pm@lfdr.de>; Fri, 15 May 2020 16:50:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726217AbgEOOuM (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Fri, 15 May 2020 10:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726213AbgEOOuM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 15 May 2020 10:50:12 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D95C061A0C;
        Fri, 15 May 2020 07:50:12 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: evelikov)
        with ESMTPSA id AC17C2A034F
Date:   Fri, 15 May 2020 15:47:32 +0100
From:   Emil Velikov <emil.velikov@collabora.com>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCHv1 03/19] power: supply: core: add manufacture date
 properties
Message-ID: <20200515144732.GC2836808@arch-x1c3>
References: <20200513185615.508236-1-sebastian.reichel@collabora.com>
 <20200513185615.508236-4-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200513185615.508236-4-sebastian.reichel@collabora.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Sebastian,

On 2020/05/13, Sebastian Reichel wrote:
> Some smart batteries store their manufacture date, which is
> useful to identify the battery and/or to know about the cell
> quality.
> 
Have you considered exposing this as a single file? Say following the ISO8601
format - YYYY-MM-DD.

-Emil
