Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EAA4C11F83F
	for <lists+linux-pm@lfdr.de>; Sun, 15 Dec 2019 16:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbfLOPCE (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Sun, 15 Dec 2019 10:02:04 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:53742 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726103AbfLOPCE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 15 Dec 2019 10:02:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=U/ljDlMG6RtqqCH2pF9yaKfI+7M0wbcBVw2/3wgsBRE=; b=SRCgCPuDcfiCH1/T+REBruHIxP
        UEXcmoosDxt12xzCOE+L1lJmf+4GgswosjvzEIwbDJ7eU6pze038h3BGx9Es+lKncWmAa8sPNcxLs
        M5q9Jyd0p1zD7+LDtqHd6q67b6BUOWoXQgIVTPI4ZCYzG+DH4s4J5vq3PJbVsYHoAP/Y=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.92.2)
        (envelope-from <andrew@lunn.ch>)
        id 1igVPA-0004gw-To; Sun, 15 Dec 2019 16:01:56 +0100
Date:   Sun, 15 Dec 2019 16:01:56 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Yangtao Li <tiny.windzz@gmail.com>
Cc:     rjw@rjwysocki.net, daniel.lezcano@linaro.org, shc_work@mail.ru,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/2] cpuidle: kirkwood: convert to
 devm_platform_ioremap_resource
Message-ID: <20191215150156.GD22725@lunn.ch>
References: <20191215130206.30265-1-tiny.windzz@gmail.com>
 <20191215130206.30265-2-tiny.windzz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191215130206.30265-2-tiny.windzz@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sun, Dec 15, 2019 at 01:02:06PM +0000, Yangtao Li wrote:
> Use devm_platform_ioremap_resource() to simplify code.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
