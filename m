Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49B6E1C7A7B
	for <lists+linux-pm@lfdr.de>; Wed,  6 May 2020 21:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbgEFTut (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 6 May 2020 15:50:49 -0400
Received: from mail.manjaro.org ([176.9.38.148]:52910 "EHLO mail.manjaro.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726093AbgEFTut (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 6 May 2020 15:50:49 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.manjaro.org (Postfix) with ESMTP id F198039E0E76;
        Wed,  6 May 2020 21:50:47 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at manjaro.org
Received: from mail.manjaro.org ([127.0.0.1])
        by localhost (manjaro.org [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id tGAS5DBpzZsm; Wed,  6 May 2020 21:50:45 +0200 (CEST)
Subject: Re: [PATCH -next] power/supply/cw2015: Make some symbols static
To:     ChenTao <chentao107@huawei.com>
Cc:     sre@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200506114519.238186-1-chentao107@huawei.com>
From:   Tobias Schramm <t.schramm@manjaro.org>
Message-ID: <0a9613a6-5557-21cb-af16-bd57d7b2a696@manjaro.org>
Date:   Wed, 6 May 2020 21:49:26 +0200
MIME-Version: 1.0
In-Reply-To: <20200506114519.238186-1-chentao107@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


> Fix the following warning:
> 
> drivers/power/supply/cw2015_battery.c:96:5: warning:
> 'cw_update_profile' was not declared. Should it be static?
> drivers/power/supply/cw2015_battery.c:712:1: warning:
> 'cw_bat_pm_ops' was not declared. Should it be static?
> 

LGTM.

Acked-by: Tobias Schramm <t.schramm@manjaro.org>
Tested-by: Tobias Schramm <t.schramm@manjaro.org>

Thanks,

Tobias
