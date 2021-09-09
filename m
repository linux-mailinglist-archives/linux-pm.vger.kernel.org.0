Return-Path: <linux-pm-owner@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C55464045F4
	for <lists+linux-pm@lfdr.de>; Thu,  9 Sep 2021 09:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235373AbhIIHKt (ORCPT <rfc822;lists+linux-pm@lfdr.de>);
        Thu, 9 Sep 2021 03:10:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:36000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236180AbhIIHKs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 9 Sep 2021 03:10:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 23BE760F13;
        Thu,  9 Sep 2021 07:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631171379;
        bh=JUdE7oTNAf0MOdz9XHbD3RU9iSFrQqNygJv8sXgwG24=;
        h=In-Reply-To:References:To:From:Cc:Subject:Date:From;
        b=GZlNRC9clI2oMaNcZgxSxbnwx6gEqAk4gNy6uQXLQ64/a8P/x31A4nwBJgvIzrpCT
         cI3G+HVKZ8gSJipJiVc8uK4TLhqSzEKELc/AbpVclPnhVcEUM0tbHdB+Eeid671j3v
         wmC2NWA0t8BepuAhsI7J+VGR8xz0RMbp4bYIdc20aca3XEmgLd4P/yDGrEiAgsOGg+
         tZlJe1el0/o/csTRpT7YNDx2vrUzoY6RZFfJCMTv0sV4eoHZq2q+n6N2JICU6FBt9O
         j03vpEu5zFXmLFuQysAxWoPUQfI2Orwth6xXypHuTc8k9TpHmOgjXLtwzTPYtV9dIT
         r4ula6EaLNCIw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <8bd5406ed111aa3c4dc180a21600811c56c6b809.camel@linux.intel.com>
References: <20210908161632.15520-1-atenart@kernel.org> <8bd5406ed111aa3c4dc180a21600811c56c6b809.camel@linux.intel.com>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        amitk@kernel.org, daniel.lezcano@linaro.org, rui.zhang@intel.com
From:   Antoine Tenart <atenart@kernel.org>
Cc:     linux-pm@vger.kernel.org
Subject: Re: [PATCH] thermal: int340x: fix tcc offset on resume
Message-ID: <163117137691.4442.5244464351443466921@kwain>
Date:   Thu, 09 Sep 2021 09:09:36 +0200
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Quoting Srinivas Pandruvada (2021-09-09 07:47:23)
>=20
> We have to mark for stable. But It mayn't cleanly apply. So we have to
> submit for 5.12+ kernels.

If this can't be easily applied on stable kernels another approach could
be to apply a simple fix (similar to the previous logic) for older
kernels[1] and applying this patch only for 5.15+.

[1] Something like:

  -static unsigned int tcc_offset_save;
  +static unsigned int tcc_offset_save =3D -1;

   int proc_thermal_resume(struct device *dev)
   {
          struct proc_thermal_device *proc_dev;
  @@ -352,7 +371,9 @@ int proc_thermal_resume(struct device *dev)
          proc_dev =3D dev_get_drvdata(dev);
          proc_thermal_read_ppcc(proc_dev);

  -       tcc_offset_update(tcc_offset_save);
  +       if (tcc_offset_save >=3D 0)
  +               tcc_offset_update(tcc_offset_save);

          return 0;
   }

Let me know if you prefer this approach.

Thanks,
Antoine
