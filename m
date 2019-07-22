Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C73E6FBA3
	for <lists+linux-pm@lfdr.de>; Mon, 22 Jul 2019 10:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728502AbfGVIyK (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Mon, 22 Jul 2019 04:54:10 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:55952 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725989AbfGVIyK (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 22 Jul 2019 04:54:10 -0400
Received: from 79.184.253.188.ipv4.supernova.orange.pl (79.184.253.188) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.267)
 id 5dd4f2870aa3b3ab; Mon, 22 Jul 2019 10:54:09 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 3/8] ACPI: EC: Return bool from acpi_ec_dispatch_gpe()
Date:   Mon, 22 Jul 2019 10:54:08 +0200
Message-ID: <2789854.IgcpE17qYE@kreacher>
In-Reply-To: <20190721163929.GA12494@amd>
References: <71085220.z6FKkvYQPX@kreacher> <4778086.90p4OrCUAx@kreacher> <20190721163929.GA12494@amd>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Sunday, July 21, 2019 6:39:29 PM CEST Pavel Machek wrote:
> On Tue 2019-07-16 18:12:59, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > On some systems, if suspend-to-idle is used, the EC may singal system
> 
> Typo "signal".

Thanks, fixed.



