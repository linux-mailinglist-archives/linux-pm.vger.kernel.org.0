Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1BBF111C9E6
	for <lists+linux-pm@lfdr.de>; Thu, 12 Dec 2019 10:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728371AbfLLJvn (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 12 Dec 2019 04:51:43 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:40980 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728452AbfLLJvn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 12 Dec 2019 04:51:43 -0500
Received: by mail-qk1-f196.google.com with SMTP id l124so1081660qkf.8
        for <linux-pm@vger.kernel.org>; Thu, 12 Dec 2019 01:51:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6MaSZO+z85RwBDn08Zp23qAhGeFPpQP6Zmbdykvp7xY=;
        b=urhpjpFmiHrpKuTd2fG68T0QYR5xRotSkvxQGdSBdbj7uuhwQwid6+6hQxFpSdUQlE
         hwTss/D6QopKGmM79dw3ZYbS0LSHqfpcYd5DiIp4Hep18HRECPd8r+CLuQ9yK0+/gFiE
         vKPYm191N11iMuemZ/RAbuUeBtuKS6vMVVfWattV+W679fW60GJvfdz769BP3JMzaktQ
         Nqe/hjKaEyfmsdJNtsBXZ/2VPLtsyN3eG+HG6Yv5u+VV190Onmu0eP+f6HlU6L15/6fk
         SC3UWY7UayBe2M/Cm1nFLBoOqK/JNQKSNYoqj5PLMfBvDMjNfWw624vk8DDEoJvbWsbG
         wobQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6MaSZO+z85RwBDn08Zp23qAhGeFPpQP6Zmbdykvp7xY=;
        b=oDbj3Z6/WW0cGp/Ai/OSIBgZFv8JwD1Csk6HGNYbtEiFlLRW+lwpVUpp0DXbUY2XeW
         utMHKSC+DEzaN7G77OR7/c0z6PpWDdkVaS1idFP+AylXbHY9cEwudYzeNXATqLmn2S7+
         hsi9fzhqTE986KzSj6uhq87/Lh2CTfM65ja+ndbQoz2CvzGC5heqGl5rvjBO7/BdvA70
         2si3gR0KT9pUSECMMwvrFZuf6KeNy+Q1IEpGPwCAntomVqBVRCp9AAWFRjJqz5Horwyw
         t+QZk+5NpUHi1uGbZALMgIZ0EBGhsM1c3NQSrEwtFGEEhMBxbkcu1ltQnSyMzY46WGOc
         ElOA==
X-Gm-Message-State: APjAAAVgj/FdAcAhWTxjymAjR+tSCBzm4erJ1IrxpvCNWkFQIDkbNHmZ
        76XfxQ0yAVFKjz+nA/AfAjhJ0ncDXrjqTlqHoCClxw==
X-Google-Smtp-Source: APXvYqy94Fq9uJhhdNDZwpWMEn9HriQ0ZfX+BDU2cUmjZQDZWmYH9ITaA+scqynbxI2D6ClS14AhIjIBkwqwJtqtFPI=
X-Received: by 2002:ae9:ed53:: with SMTP id c80mr6874474qkg.445.1576144301706;
 Thu, 12 Dec 2019 01:51:41 -0800 (PST)
MIME-Version: 1.0
References: <20191127053836.31624-1-drake@endlessm.com>
In-Reply-To: <20191127053836.31624-1-drake@endlessm.com>
From:   Daniel Drake <drake@endlessm.com>
Date:   Thu, 12 Dec 2019 17:51:30 +0800
Message-ID: <CAD8Lp47zSV9hB8_qJv24YFae1bfE2LwqA_jChBQFpBOac5a2RA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] PCI: add generic quirk function for increasing
 D3hot delay
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Linux PCI <linux-pci@vger.kernel.org>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        Linux Upstreaming Team <linux@endlessm.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux USB Mailing List <linux-usb@vger.kernel.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi Bjorn,

On Wed, Nov 27, 2019 at 1:38 PM Daniel Drake <drake@endlessm.com> wrote:
> Separate the D3 delay increase functionality out of quirk_radeon_pm() into
> its own function so that it can be shared with other quirks, including
> the AMD Ryzen XHCI quirk that will be introduced in a followup commit.
>
> Tweak the function name and message to indicate more clearly that the
> delay relates to a D3hot-to-D0 transition.

Any update on these pending patches?

Thanks
Daniel
