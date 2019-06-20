Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87CFB4DD69
	for <lists+linux-pm@lfdr.de>; Fri, 21 Jun 2019 00:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726135AbfFTWZw (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 20 Jun 2019 18:25:52 -0400
Received: from mail4.protonmail.ch ([185.70.40.27]:33879 "EHLO
        mail4.protonmail.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbfFTWZw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 20 Jun 2019 18:25:52 -0400
X-Greylist: delayed 444 seconds by postgrey-1.27 at vger.kernel.org; Thu, 20 Jun 2019 18:25:51 EDT
Date:   Thu, 20 Jun 2019 22:18:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=philipmolloy.com;
        s=protonmail; t=1561069106;
        bh=o+PFeJ5YEwKfmogZjjcfo2VWfzgLtuAT/POmeapFTnw=;
        h=Date:To:From:Reply-To:Subject:Feedback-ID:From;
        b=kNnMy1fnOqYqlNXKrGioJmQ36eVuG0JlMHMuzA5waH5MWtE+kEPLr5toca5s2hwG3
         6PxkjypU2Sbe9eomSnlcrmzOYXyna8ONvC910JgDTBNWU/GswO5OYVOyvxGoDEdYGX
         vVr1bcCI6zdM+rEricy4PDe47LtSV4zfXQe+MWbg=
To:     "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
From:   Philip Molloy <philip@philipmolloy.com>
Reply-To: Philip Molloy <philip@philipmolloy.com>
Subject: Power domain configuration for a i2c module
Message-ID: <LBvyayNVX8_SOsSXpNSqiBACOGjM2Bu-Fz-D_gW850M9ZJQVEk6WVxzipUn9O4n15435v4yHSIVYp0HgKUcSkTt_hTIEA3XZ0FZLSyEKipY=@philipmolloy.com>
Feedback-ID: GJt-tMfvxqs0QQBY3TE43pQhGJvmgUyYcaVNLwpOk7zQA3Z8eEn7lfwmGEZNv6-1MJvpWrQYi2j-a_XpfopQjA==:Ext:ProtonMail
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.2 required=7.0 tests=ALL_TRUSTED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF autolearn=ham
        autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on mail.protonmail.ch
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

I could use a little help understanding how to set up a power domain for a =
i2c module. I have corresponding drivers for each i2c device on the module.=
 The i2c devices are all behind a i2c-mux-gpio and a physical i2c mux due t=
o some interesting hardware design choices. I have written a module power d=
river that hooks up a power GPIO pin to the runtime power management subsys=
tem by implementing dev_pm_ops, calling pm_runtime_enable(), etc.

In the device tree node corresponding to the module power driver I have add=
ed `#power-domain-cells =3D <0>;` to configure it as a provider. And for ea=
ch i2c device on the module I've added `power-domains` and `power-domains-n=
ames` to configure them as consumers.

I'm stuck on what I need to implement to hook this all up. I've done a fair=
 amount of reading, debugging and looking for examples, but it still isn't =
evident to me what is done automatically and what I need to implement. For =
example, i2c-mux-gpio is a platform driver and dev_pm_domain_attach(dev, tr=
ue) is called from platform_drv_probe() so I thought the domain might just =
power on when i2c-mux-gpio is probed, but that's not what I experienced. No=
te, my module power driver is also a platform driver.

Any help would be greatly appreciated.

Best,
Philip
