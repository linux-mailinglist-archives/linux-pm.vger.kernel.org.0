Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3B44227A78
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jul 2020 10:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726919AbgGUITJ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 Jul 2020 04:19:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:44182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726089AbgGUITJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 21 Jul 2020 04:19:09 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 93D5D20720;
        Tue, 21 Jul 2020 08:19:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595319549;
        bh=TYERl2SMOVxHa6xdDVBmiIMbf9QEZlOcozrjEFlYSH0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QzFSRSDFZ0Zp2iih6yelFAtd5iZJmpwXhxa/zRyQwFwTY0xsOI3VXj4xmpBizWlg8
         Jh4c9pPcpQT01+M742B21N8pyazczeegGb/is9qviuh57Yrzrhox5D0MNtP5GkJJDM
         Z12Vu8ekMweEWT3G/PiYFW6u2yUYJqmpTGjtUyS8=
Date:   Tue, 21 Jul 2020 10:19:17 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Qiwu Huang <yanziily@gmail.com>
Cc:     sre@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, jiangfei1@xiaomi.com,
        Qiwu Huang <huangqiwu@xiaomi.com>
Subject: Re: [PATCH v5 2/4] power: supply: core: add wireless charger adapter
 type property
Message-ID: <20200721081917.GC1655283@kroah.com>
References: <cover.1595301250.git.huangqiwu@xiaomi.com>
 <8a46e20d48d34f898b26cccfee562735894b08ae.1595301250.git.huangqiwu@xiaomi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a46e20d48d34f898b26cccfee562735894b08ae.1595301250.git.huangqiwu@xiaomi.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 21, 2020 at 01:59:35PM +0800, Qiwu Huang wrote:
> From: Qiwu Huang <huangqiwu@xiaomi.com>
> 
> Reports what type of wireless adapter connection is
> currently active for the supply.
> for example it can show if ADAPTER_PD capable source is attached.
> 
> Signed-off-by: Qiwu Huang <huangqiwu@xiaomi.com>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
