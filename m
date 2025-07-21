Return-Path: <linux-pm+bounces-31222-lists+linux-pm=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pm@lfdr.de
Delivered-To: lists+linux-pm@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C71A8B0C8F2
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 18:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB04117A8C4
	for <lists+linux-pm@lfdr.de>; Mon, 21 Jul 2025 16:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C1AC2DECD8;
	Mon, 21 Jul 2025 16:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QjO6c26V"
X-Original-To: linux-pm@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A6F1FF7D7;
	Mon, 21 Jul 2025 16:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753115990; cv=none; b=j9XR9e5iMXl6J438pi3BdCt8Vw1G8x6oMnigU3greY7on0q33Wm0e2zxp3XXirxpUQI1XhLfHleIfMh2BCbmBNGsBE3AoEG2m2NPIZOdYVjq9NFBJteIhbDlblvdkjnLgeITOwvZtD0x11xKa8Mv7dyuokCTNbbSQSsRsz/d4jQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753115990; c=relaxed/simple;
	bh=0M2kegxVrOG9bbNIWsfmtfYN+NJqZkcIDUBbMnlp/fk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n9q4M18G1M6K6Ey6op76so3PwksLdWUfw1bYtpKRRorY6fGfpEzbymU+RAussgOqGnuDMjlRMaKFjBY4KKNX4webYM/fAlqXKG4ciTyTYw1y8Bv6rmdNbd4OClBIr7eHkoUtPOdmgV2KF75IUs9lDty9LPrPheIR0jXDyDNk0vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QjO6c26V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BF7DC4CEF7;
	Mon, 21 Jul 2025 16:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753115989;
	bh=0M2kegxVrOG9bbNIWsfmtfYN+NJqZkcIDUBbMnlp/fk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QjO6c26VaT5pOK+EqFwDQZgVVFf1bWRB70rU4TqCWQNnN8yz58o11cW2GPvmQZCX4
	 ZEnlCBB+CUY4RzRqFIf7FxtkL1NhZCToTl1eyn/7zsNHX8NXTFodD7B9RJKwTSz8ZY
	 2y3Gzh+QPLbBMPlHlJRPrKJQVKUWtTIco+nmn9kwD6m9+PyQkcSVo35xni35IkSJOZ
	 GZeleVNUy6mCyxJht26f48pRbzZRr/LQYrX1kzX2cieL3nd+pf3lZE0dH7pCZ4rGV4
	 q5WnN7LUfvoGPBpph1JkgHZX26eX1ujOEU+iGPXEGEzRdUEQ5txrONZ+wJ8ZHebLad
	 kLKnF0GB0/pNg==
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-613a6e39f52so1791210eaf.3;
        Mon, 21 Jul 2025 09:39:49 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVrtKhk/64CJ7Sko+q5KkR6xDHZDRqZ+7ntqBnvnesV6cdiYSiXxlQFUIEwYTo1v8pQRafzsgilyEc=@vger.kernel.org, AJvYcCXlfQlG6f1HTUIyyW2Fzxx3AMlkRORL96DQ/fqCN1DW1Ed4Y78GLiuAq0cKiGG5uLVvpUkEzFl0e6oLvys=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGoHO1A0Bu47D7H2wD2AQB37GW/zV+DuU/j882AyssquGKxIAn
	9XDXrZ+iBswYiaymD/My/J6Cp588alzVbd5V8WIarAt+bMvR7T/FoB41Y8U8SwXMkVe4wdSbaxd
	9pflt/9G8JKo3mm2UMICNa3t1qdowYM4=
X-Google-Smtp-Source: AGHT+IG6ruTxet2aCkfZ15+Zb6qqzelc3GS7/NSmDucWVUx9SEYBfsHFnr0MjU/etVc+hR0GVrJPLYbXmXvFz5XSSpk=
X-Received: by 2002:a05:6820:905:b0:611:b142:20ed with SMTP id
 006d021491bc7-615a1fa2b2amr14848833eaf.7.1753115988825; Mon, 21 Jul 2025
 09:39:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250716123323.65441-1-ulf.hansson@linaro.org> <20250716123323.65441-2-ulf.hansson@linaro.org>
In-Reply-To: <20250716123323.65441-2-ulf.hansson@linaro.org>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 21 Jul 2025 18:39:37 +0200
X-Gmail-Original-Message-ID: <CAJZ5v0iq7UODJ83fkwnzfFR3HpG2_R-YRnip_cLwyUHZZ+rXyg@mail.gmail.com>
X-Gm-Features: Ac12FXy_3rMe-tmgsVrMlt1HCZQ2tNv69WiTVXn1w_eRtCIN6SbSDP4tdmRw4ns
Message-ID: <CAJZ5v0iq7UODJ83fkwnzfFR3HpG2_R-YRnip_cLwyUHZZ+rXyg@mail.gmail.com>
Subject: Re: [RFC/PATCH 1/3] PM: QoS: Introduce a system-wakeup QoS limit
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>, linux-pm@vger.kernel.org, 
	Kevin Hilman <khilman@baylibre.com>, Pavel Machek <pavel@kernel.org>, Len Brown <len.brown@intel.com>, 
	Daniel Lezcano <daniel.lezcano@linaro.org>, Saravana Kannan <saravanak@google.com>, 
	Maulik Shah <quic_mkshah@quicinc.com>, Prasad Sodagudi <psodagud@quicinc.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 16, 2025 at 2:33=E2=80=AFPM Ulf Hansson <ulf.hansson@linaro.org=
> wrote:
>
> Some platforms and devices supports multiple low-power-states than can be
> used for system-wide suspend. Today these states are selected on per
> subsystem basis and in most cases it's the deepest possible state that
> becomes selected.
>
> For some use-cases this is a problem as it isn't suitable or even breaks
> the system-wakeup latency constraint, when we decide to enter these deepe=
r
> states during system-wide suspend.
>
> Therefore, let's introduce an interface for user-space, allowing us to
> specify the system-wakeup QoS limit. Subsequent changes will start taking
> into account the QoS limit.

Well, this is not really a system-wakeup limit, but a CPU idle state
latency limit for states entered in the last step of suspend-to-idle.

It looks like the problem is that the existing CPU latency QoS is not
taken into account by suspend-to-idle, so instead of adding an
entirely new interface to overcome this, would it make sense to add an
ioctl() to the existing one that would allow the user of it to
indicate that the given request should also be respected by
suspend-to-idle?

There are two basic reasons why I think so:
(1) The requests that you want to be respected by suspend-to-idle
should also be respected by the regular "runtime" idle, or at least I
don't see a reason why it wouldn't be the case.
(2) The new interface introduced by this patch basically duplicates
the existing one.

The flow related to this I kind of envision would be as follows:
(1) User space opens /dev/cpu_dma_latency and a single CPU latency QoS
request is created via cpu_latency_qos_add_request().
(2) User space calls a new ioctl() on the open file descriptor to
indicate that the request should also apply to suspend-to-idle.  A new
request is created with the same value and added to a new list of
constraints.  That new list of constraints will be used by
suspend-to-idle.
(3) Writing to the open file descriptor causes both requests to be updated.
(4) If user space does not want the request to apply to
suspend-to-idle any more, it can use another new ioctl() to achieve
that.  It would cause the second (suspend-to-idle) copy of the request
to be dropped.
(5) Closing the file descriptor causes both copies of the request to be dro=
pped.

> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> ---
>  include/linux/pm_qos.h |   9 ++++
>  kernel/power/qos.c     | 114 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 123 insertions(+)
>
> diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
> index 4a69d4af3ff8..5f84084f19c8 100644
> --- a/include/linux/pm_qos.h
> +++ b/include/linux/pm_qos.h
> @@ -143,6 +143,15 @@ bool pm_qos_update_flags(struct pm_qos_flags *pqf,
>                          struct pm_qos_flags_request *req,
>                          enum pm_qos_req_action action, s32 val);
>
> +#ifdef CONFIG_PM_SLEEP
> +s32 system_wakeup_latency_qos_limit(void);
> +#else
> +static inline s32 system_wakeup_latency_qos_limit(void)
> +{
> +       return PM_QOS_RESUME_LATENCY_NO_CONSTRAINT;
> +}
> +#endif
> +
>  #ifdef CONFIG_CPU_IDLE
>  s32 cpu_latency_qos_limit(void);
>  bool cpu_latency_qos_request_active(struct pm_qos_request *req);
> diff --git a/kernel/power/qos.c b/kernel/power/qos.c
> index 4244b069442e..fb496c220ffe 100644
> --- a/kernel/power/qos.c
> +++ b/kernel/power/qos.c
> @@ -209,6 +209,120 @@ bool pm_qos_update_flags(struct pm_qos_flags *pqf,
>         return prev_value !=3D curr_value;
>  }
>
> +#ifdef CONFIG_PM_SLEEP
> +static struct pm_qos_constraints system_wakeup_latency_constraints =3D {
> +       .list =3D PLIST_HEAD_INIT(system_wakeup_latency_constraints.list)=
,
> +       .target_value =3D PM_QOS_RESUME_LATENCY_NO_CONSTRAINT,
> +       .default_value =3D PM_QOS_RESUME_LATENCY_NO_CONSTRAINT,
> +       .no_constraint_value =3D PM_QOS_RESUME_LATENCY_NO_CONSTRAINT,
> +       .type =3D PM_QOS_MIN,
> +};
> +
> +/**
> + * system_wakeup_latency_qos_limit - Current system wakeup latency QoS l=
imit.
> + *
> + * Returns the current system wakeup latency QoS limit that may have bee=
n
> + * requested by user-space.
> + */
> +s32 system_wakeup_latency_qos_limit(void)
> +{
> +       return pm_qos_read_value(&system_wakeup_latency_constraints);
> +}
> +
> +static int system_wakeup_latency_qos_open(struct inode *inode,
> +                                         struct file *filp)
> +{
> +       struct pm_qos_request *req;
> +
> +       req =3D kzalloc(sizeof(*req), GFP_KERNEL);
> +       if (!req)
> +               return -ENOMEM;
> +
> +       req->qos =3D &system_wakeup_latency_constraints;
> +       pm_qos_update_target(req->qos, &req->node, PM_QOS_ADD_REQ,
> +                            PM_QOS_RESUME_LATENCY_NO_CONSTRAINT);
> +       filp->private_data =3D req;
> +
> +       return 0;
> +}
> +
> +static int system_wakeup_latency_qos_release(struct inode *inode,
> +                                            struct file *filp)
> +{
> +       struct pm_qos_request *req =3D filp->private_data;
> +
> +       filp->private_data =3D NULL;
> +       pm_qos_update_target(req->qos, &req->node, PM_QOS_REMOVE_REQ,
> +                            PM_QOS_RESUME_LATENCY_NO_CONSTRAINT);
> +       kfree(req);
> +
> +       return 0;
> +}
> +
> +static ssize_t system_wakeup_latency_qos_read(struct file *filp,
> +                                             char __user *buf,
> +                                             size_t count,
> +                                             loff_t *f_pos)
> +{
> +       s32 value =3D pm_qos_read_value(&system_wakeup_latency_constraint=
s);
> +
> +       return simple_read_from_buffer(buf, count, f_pos, &value, sizeof(=
s32));
> +}
> +
> +static ssize_t system_wakeup_latency_qos_write(struct file *filp,
> +                                              const char __user *buf,
> +                                              size_t count, loff_t *f_po=
s)
> +{
> +       struct pm_qos_request *req =3D filp->private_data;
> +       s32 value;
> +
> +       if (count =3D=3D sizeof(s32)) {
> +               if (copy_from_user(&value, buf, sizeof(s32)))
> +                       return -EFAULT;
> +       } else {
> +               int ret;
> +
> +               ret =3D kstrtos32_from_user(buf, count, 16, &value);
> +               if (ret)
> +                       return ret;
> +       }
> +
> +       if (value < 0)
> +               return -EINVAL;
> +
> +       pm_qos_update_target(req->qos, &req->node, PM_QOS_UPDATE_REQ, val=
ue);
> +
> +       return count;
> +}
> +
> +static const struct file_operations system_wakeup_latency_qos_fops =3D {
> +       .open =3D system_wakeup_latency_qos_open,
> +       .release =3D system_wakeup_latency_qos_release,
> +       .read =3D system_wakeup_latency_qos_read,
> +       .write =3D system_wakeup_latency_qos_write,
> +       .llseek =3D noop_llseek,
> +};
> +
> +static struct miscdevice system_wakeup_latency_qos_miscdev =3D {
> +       .minor =3D MISC_DYNAMIC_MINOR,
> +       .name =3D "system_wakeup_latency",
> +       .fops =3D &system_wakeup_latency_qos_fops,
> +};
> +
> +static int __init system_wakeup_latency_qos_init(void)
> +{
> +       int ret;
> +
> +       ret =3D misc_register(&system_wakeup_latency_qos_miscdev);
> +       if (ret < 0)
> +               pr_err("%s: %s setup failed\n", __func__,
> +                      system_wakeup_latency_qos_miscdev.name);
> +
> +       return ret;
> +}
> +late_initcall(system_wakeup_latency_qos_init);
> +#endif /* CONFIG_PM_SLEEP */
> +
>  #ifdef CONFIG_CPU_IDLE
>  /* Definitions related to the CPU latency QoS. */
>
> --

