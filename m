Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27B0F58D8B
	for <lists+linux-pm@lfdr.de>; Fri, 28 Jun 2019 00:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbfF0WDR (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 27 Jun 2019 18:03:17 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:49672 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726498AbfF0WDR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 27 Jun 2019 18:03:17 -0400
Received: from 79.184.254.216.ipv4.supernova.orange.pl (79.184.254.216) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id 53583284a03059e6; Fri, 28 Jun 2019 00:03:15 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     linux-pm@vger.kernel.org
Subject: Re: [PATCH 0/3] powercap/intel_rapl: add support for more Icelake platforms
Date:   Fri, 28 Jun 2019 00:03:15 +0200
Message-ID: <2810604.mF1Qch8YXu@kreacher>
In-Reply-To: <1560778395-15088-1-git-send-email-rui.zhang@intel.com>
References: <1560778395-15088-1-git-send-email-rui.zhang@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Monday, June 17, 2019 3:33:12 PM CEST Zhang Rui wrote:
> This patch series add intel_rapl support for more IceLake platforms including
> ICX, ICX-D and ICL desktop.
> 
> Note that all the patches depend on commit e35faeb64146
> ("x86/CPU: Add more Icelake model numbers") which is just merged in 5.2-rc5.
> 
> thanks,
> rui
> 
> 

All three applied, thanks!




