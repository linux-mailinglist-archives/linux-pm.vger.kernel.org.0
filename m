Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E12E0145F45
	for <lists+linux-pm@lfdr.de>; Thu, 23 Jan 2020 00:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725924AbgAVXnQ (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Wed, 22 Jan 2020 18:43:16 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:40321 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbgAVXnP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 22 Jan 2020 18:43:15 -0500
Received: by mail-ot1-f66.google.com with SMTP id w21so1058650otj.7;
        Wed, 22 Jan 2020 15:43:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rg2sJY9T4OUkKUiiUMINOLh/A2PlIFpIRvK2N4+oA0g=;
        b=d6Wd7h5iczotLNZBfv9/rn+1XBQ0omRbNJOs0icBRWeogE7rd8NpPtqOc8omgyvguv
         xVRSP2zixFeclDrreSg7bCPGvnuvsONmpW1yRL0uEz0gWIk+g3mCJHIjBsuiDtYNS/3q
         OKopS8L09IEC2EI0dCRlULXQDZqsRhIYo+fvNsva68uLZOI0Uiu0aQjLVPI1twbQj+v8
         QZZGwAD3DfdxFtrsddVe901850auNm18BMYlhEAwU3eZzKVDEOMMVn9rdYs0dyO92mnf
         rjwFERIX+nYAcGMDNc8+ZVwmSTWpyFcdMrs4UIkolSIBRtYxFpniPHIdV2EGriW0UFu5
         hHuw==
X-Gm-Message-State: APjAAAXbVuD6JQ/p7io+xdmAwEgkPMD2/GCpy9aAXmTf6YYttQXvNqlU
        UScRcJfg6kTMbztEgG+KYaZFlbo0xPCrcJwu3To=
X-Google-Smtp-Source: APXvYqz6qzUjXWXO6gWRvzrGGlHgE0zXKCMAkk5lqmmx1NMk+/7gsSn+Rz7gMuL0HtE+vyi6W8CmIWSAbx/9bubQpRA=
X-Received: by 2002:a05:6830:1e67:: with SMTP id m7mr9285079otr.262.1579736594807;
 Wed, 22 Jan 2020 15:43:14 -0800 (PST)
MIME-Version: 1.0
References: <20200120133359.1672-1-benjamin.gaignard@st.com>
In-Reply-To: <20200120133359.1672-1-benjamin.gaignard@st.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Thu, 23 Jan 2020 00:43:03 +0100
Message-ID: <CAJZ5v0gOq_gP3ghyJ80MSLSrDbqRGQRpMfQ=TLv78wZ4fDKeuw@mail.gmail.com>
Subject: Re: [PATCH] cpuidle: sysfs: fix warning when compiling with W=1
To:     Benjamin Gaignard <benjamin.gaignard@st.com>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

On Mon, Jan 20, 2020 at 2:34 PM Benjamin Gaignard
<benjamin.gaignard@st.com> wrote:
>
> Fix kernel documentation comments to remove the warnings when
> compiling with W=1.
>
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>
> ---
>  drivers/cpuidle/sysfs.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/cpuidle/sysfs.c b/drivers/cpuidle/sysfs.c
> index 38ef770be90d..1909584e1e50 100644
> --- a/drivers/cpuidle/sysfs.c
> +++ b/drivers/cpuidle/sysfs.c
> @@ -142,6 +142,7 @@ static struct attribute_group cpuidle_attr_group = {
>
>  /**
>   * cpuidle_add_interface - add CPU global sysfs attributes
> + * @dev: the target device
>   */
>  int cpuidle_add_interface(struct device *dev)
>  {
> @@ -153,6 +154,7 @@ int cpuidle_add_interface(struct device *dev)
>
>  /**
>   * cpuidle_remove_interface - remove CPU global sysfs attributes
> + * @dev: the target device
>   */
>  void cpuidle_remove_interface(struct device *dev)
>  {
> @@ -615,7 +617,7 @@ static struct kobj_type ktype_driver_cpuidle = {
>
>  /**
>   * cpuidle_add_driver_sysfs - adds the driver name sysfs attribute
> - * @device: the target device
> + * @dev: the target device
>   */
>  static int cpuidle_add_driver_sysfs(struct cpuidle_device *dev)
>  {
> @@ -646,7 +648,7 @@ static int cpuidle_add_driver_sysfs(struct cpuidle_device *dev)
>
>  /**
>   * cpuidle_remove_driver_sysfs - removes the driver name sysfs attribute
> - * @device: the target device
> + * @dev: the target device
>   */
>  static void cpuidle_remove_driver_sysfs(struct cpuidle_device *dev)
>  {
> --

Queued up as 5.6 material, thanks!
