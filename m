Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38799227A6F
	for <lists+linux-pm@lfdr.de>; Tue, 21 Jul 2020 10:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgGUISp (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Tue, 21 Jul 2020 04:18:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:43836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726089AbgGUISp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 21 Jul 2020 04:18:45 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2731F2068F;
        Tue, 21 Jul 2020 08:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595319524;
        bh=FBJQa3FzkY0nyJqADE7Z/ZHWqoJDA0scjTK50ZIbgFs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vVb7R8w9/m1ckbQMlt3FV4OuSERrvyMyR3UVQONJDsEG/8OZgrpZyagIHKmNVR1kr
         vo8Cybwvt9s6SU9KWKy0MRjkQCHPcklObClw167H2sikvmcwnDoTpNuGt7oYE2k99c
         AwT8t37gNDWM4zGH14cWPnOqYL7B3/ePWrPVNatc=
Date:   Tue, 21 Jul 2020 10:18:53 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Qiwu Huang <yanziily@gmail.com>
Cc:     sre@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, jiangfei1@xiaomi.com,
        Qiwu Huang <huangqiwu@xiaomi.com>
Subject: Re: [PATCH v5 1/4] power: supply: core: add quick charge type
 property
Message-ID: <20200721081853.GB1655283@kroah.com>
References: <cover.1595301250.git.huangqiwu@xiaomi.com>
 <c9d3199ec18625f9cc4448c3b2049ea2ae80358b.1595301250.git.huangqiwu@xiaomi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9d3199ec18625f9cc4448c3b2049ea2ae80358b.1595301250.git.huangqiwu@xiaomi.com>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Tue, Jul 21, 2020 at 01:59:34PM +0800, Qiwu Huang wrote:
> From: Qiwu Huang <huangqiwu@xiaomi.com>
> 
> Reports the kind of quick charge type based on
> different adapter power.
> 
> Signed-off-by: Qiwu Huang <huangqiwu@xiaomi.com>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
