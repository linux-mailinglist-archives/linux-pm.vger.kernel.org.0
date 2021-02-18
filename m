Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B430E31EA50
	for <lists+linux-pm@lfdr.de>; Thu, 18 Feb 2021 14:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbhBRNPV (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 18 Feb 2021 08:15:21 -0500
Received: from mail.manjaro.org ([176.9.38.148]:58366 "EHLO mail.manjaro.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232697AbhBRMXt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 18 Feb 2021 07:23:49 -0500
Received: from localhost (localhost [127.0.0.1])
        by mail.manjaro.org (Postfix) with ESMTP id C220C3E60837;
        Thu, 18 Feb 2021 13:22:24 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at manjaro.org
Received: from mail.manjaro.org ([127.0.0.1])
        by localhost (manjaro.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id BdtmzXmJxxpp; Thu, 18 Feb 2021 13:22:22 +0100 (CET)
Subject: Re: [PATCH] Add CHARGE_NOW support to cw2015_battery.c
To:     Martin Ashby <martin@ashbysoft.com>, t.schramm@manjaro.org,
        linux-pm@vger.kernel.org
References: <20210216193217.144803-1-martin@ashbysoft.com>
From:   Tobias Schramm <t.schramm@manjaro.org>
Message-ID: <8ea982e3-83a9-7be3-6339-d658900967de@manjaro.org>
Date:   Thu, 18 Feb 2021 13:22:18 +0100
MIME-Version: 1.0
In-Reply-To: <20210216193217.144803-1-martin@ashbysoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Martin,

thanks for the updated patch.

I just noticed that the patch subject is not ideal. Please have a look 
at the git log of cw2015_battery.c. You will see that the commit subject 
always starts with prefix "power: supply: cw2015:". That makes it a lot 
easier to grasp which subsystem a certain commit is about. Would you 
mind sending a v2 of your patch that does that, too?

Cheers,
Tobias
