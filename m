Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7221D24B5C9
	for <lists+linux-pm@lfdr.de>; Thu, 20 Aug 2020 12:28:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730394AbgHTK2O (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Aug 2020 06:28:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:46132 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731854AbgHTK1s (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 20 Aug 2020 06:27:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 53E5CAE33;
        Thu, 20 Aug 2020 10:28:14 +0000 (UTC)
From:   Thomas Renninger <trenn@suse.com>
To:     shuah@kernel.org, Martin Kaistra <martin.kaistra@linutronix.de>
Cc:     linux-pm@vger.kernel.org
Subject: Re: [PATCH] cpupower: speed up generating git version string
Date:   Thu, 20 Aug 2020 12:27:46 +0200
Message-ID: <1698400.ZyLY7WPuaR@c100>
In-Reply-To: <20200812094912.2648-1-martin.kaistra@linutronix.de>
References: <20200812094912.2648-1-martin.kaistra@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Am Mittwoch, 12. August 2020, 11:49:12 CEST schrieb Martin Kaistra:
> The variable VERSION is expanded for every use of CFLAGS. This causes
> "git describe" to get called multiple times on the kernel tree, which
> can be quite slow.
> 
> The git revision does not change during build, so we can use simple
> variable expansion to set VERSION.

Good catch,  thanks!

Acked-by: Thomas Renninger <trenn@suse.de>



